// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/view/screens/widgets/chat_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<MessagesModel> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments  as String;

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
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          right: 10,
          left: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    messagesList = state.message;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatContainer(messagesModel: messagesList[index])
                          : ChatContainerFriend(
                              messagesModel: messagesList[index]);
                    },
                  );
                },
              ),
            ),
            TextField(
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
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
      ),
    );
  }
}
