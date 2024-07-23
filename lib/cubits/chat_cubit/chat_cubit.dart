import 'package:app_chat/model/chat_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference msgg = FirebaseFirestore.instance.collection('msg');
  List<chat_model> chat_list = [];
  void send_msg({required msg, required id_email}) {
    try {
      msgg.add({
        'msg': msg,
        'creater_at': DateTime.now(),
        'id': id_email,
      });
    } catch (e) {}
  }

  void get_msg() {
    msgg.orderBy('creater_at', descending: true).snapshots().listen((event) {
      chat_list.clear();
      for (var doc in event.docs) {
        chat_list.add(chat_model.fromjson(doc));
      }

      emit(Chatsccess(chat_list_msg: chat_list));
    });
  }
}
