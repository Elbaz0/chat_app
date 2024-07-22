import 'package:app_chat/main.dart';
import 'package:app_chat/model/chat_model.dart';
import 'package:app_chat/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chat extends StatelessWidget {
  chat({
    super.key,
  });

  CollectionReference msgg = FirebaseFirestore.instance.collection('msg');

  var controller = TextEditingController();

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var id_email = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
        stream: msgg.orderBy('creater_at', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<chat_model> chat_list = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              chat_list.add(chat_model.fromjson(snapshot.data!.docs[i]));
            }

            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: keycolor,
                ),
                body: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: chat_list.length,
                      itemBuilder: (context, index) {
                        return chat_list[index].id == id_email
                            ? chatbubble(
                                msg: chat_list[index],
                              )
                            : chatbubble_frind(
                                msg: chat_list[index],
                              );
                      },
                    ),
                  ),
                  Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: button_msg(
                          controller: controller,
                          msgg: msgg,
                          id_email: id_email,
                          controller2: _controller),
                    ),
                  )
                ]));
          } else {
            return Center(
                child: Text(
              'loading ...',
              style: TextStyle(fontSize: 30, color: keycolor),
            ));
          }
        });
  }
}

class button_msg extends StatelessWidget {
  const button_msg({
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
