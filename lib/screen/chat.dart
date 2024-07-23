import 'package:app_chat/main.dart';
import 'package:app_chat/model/chat_model.dart';
import 'package:app_chat/widget/buttom_msg.dart';
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
              chat_list.add(
                chat_model.fromjson(snapshot.data!.docs[i]),
              );
            }

            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
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
                      child: buttom_msg(
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
