// ignore_for_file: must_be_immutable

part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  Color color;
  LoginSuccess({required this.color});
}

final class LoginFailure extends LoginState {
  String errorMessage;
  Color color;
  LoginFailure({required this.errorMessage, required this.color});
}