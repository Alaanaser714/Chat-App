// ignore_for_file: must_be_immutable

part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  Color color;
  String successMessage;

  RegisterSuccess({required this.color, required this.successMessage});
}

final class RegisterFailure extends RegisterState {
  String errorMessage;
  Color color;
  RegisterFailure({required this.errorMessage, required this.color});
}
