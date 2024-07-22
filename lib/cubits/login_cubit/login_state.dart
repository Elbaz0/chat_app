part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSccess extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginField extends LoginState {
  String msg_erorre;
  LoginField({required this.msg_erorre});
}
