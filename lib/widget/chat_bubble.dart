import 'package:app_chat/main.dart';
import 'package:app_chat/model/chat_model.dart';
import 'package:flutter/material.dart';

class chatbubble extends StatelessWidget {
  const chatbubble({super.key, required this.msg});
  final chat_model msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(164, 205, 16, 177),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Text(
          msg.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class chatbubble_frind extends StatelessWidget {
  const chatbubble_frind({super.key, required this.msg});
  final chat_model msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 186, 0, 158),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Text(
          msg.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
