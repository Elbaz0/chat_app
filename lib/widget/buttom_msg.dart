import 'package:app_chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class buttom_msg extends StatelessWidget {
  const buttom_msg({
    super.key,
    required this.controller,
    required this.msgg,
    required this.id_email,
    required ScrollController controller2,
  }) : _controller = controller2;

  final TextEditingController controller;
  final CollectionReference<Object?> msgg;
  final Object? id_email;
  final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (data) {
        msgg.add({
          'msg': data,
          'creater_at': DateTime.now(),
          'id': id_email,
        });
        controller.clear();
        _controller.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      },
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.send,
          color: keycolor,
        ),
        hintText: 'send msg',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
