// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/view/screens/widgets/chat_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("time", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessagesModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(MessagesModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xff2B475E),
              title: const Text(
                "Chat App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Parkinsans",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatContainer(messagesModel: messagesList[index])
                          : ChatContainerFriend(
                              messagesModel: messagesList[index]);
                    },
                  ),
                ),
                TextField(
                  onSubmitted: (data) {
                    messages.add({
                      'messages': data,
                      "time": DateTime.now(),
                      "id": email
                    });
                    controller.clear();
                    _controller.animateTo(
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Send messages",
                    suffixIcon: Icon(
                      Icons.send,
                      size: 35,
                      color: Color(0xff2B475E),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xff2B475E),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xff2B475E),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}