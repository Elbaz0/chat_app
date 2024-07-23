import 'package:app_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:app_chat/main.dart';
import 'package:app_chat/model/chat_model.dart';

import 'package:app_chat/widget/chat_bubble.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class chat extends StatelessWidget {
  chat({
    super.key,
  });

  var controller = TextEditingController();

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var id_email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Chat',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
          backgroundColor: keycolor,
        ),
        body: Column(children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var chat_list = BlocProvider.of<ChatCubit>(context).chat_list;
                return ListView.builder(
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
                );
              },
            ),
          ),
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context)
                      .send_msg(msg: data, id_email: id_email);
                  controller.clear();
                  _controller.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: keycolor,
                    ),
                    onPressed: () {},
                  ),
                  hintText: 'send msg',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
