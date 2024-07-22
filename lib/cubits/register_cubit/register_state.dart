part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class registerInitial extends RegisterState {}

final class registerSccess extends RegisterState {}

final class registerLoading extends RegisterState {}

final class registerField extends RegisterState {
  String msg_erorre;
  registerField({required this.msg_erorre});
}
