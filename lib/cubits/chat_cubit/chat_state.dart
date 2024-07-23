part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class Chatsccess extends ChatState {
  List<chat_model> chat_list_msg;
  Chatsccess({required this.chat_list_msg});
}
