import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference msgg = FirebaseFirestore.instance.collection('msg');
  void send_msg({required data, required id_email}) {
    try {
      msgg.add({
        'msg': data,
        'creater_at': DateTime.now(),
        'id': id_email,
      });
    } catch (e) {}
  }

  void get_msg() {
    msgg.orderBy('creater_at', descending: true).snapshots().listen((event) {
      emit(Chatsccess());
    });
  }
}
