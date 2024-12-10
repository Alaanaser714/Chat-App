// ignore_for_file: prefer_const_constructors

import 'package:chat_app/models/messages_model.dart';
import 'package:flutter/material.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    super.key,
    required this.messagesModel,
  });

  final MessagesModel messagesModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(33),
            topRight: Radius.circular(33),
            topLeft: Radius.circular(33),
          ),
          color: Color(0xff2B475E),
        ),
        child: Text(
          messagesModel.message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Parkinsans",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ChatContainerFriend extends StatelessWidget {
  const ChatContainerFriend({
    super.key,
    required this.messagesModel,
  });

  final MessagesModel messagesModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(33),
            topRight: Radius.circular(33),
            topLeft: Radius.circular(33),
          ),
          color: Colors.blue,
        ),
        child: Text(
          messagesModel.message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Parkinsans",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
