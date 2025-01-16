// ignore_for_file: must_be_immutable

part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {
  List<MessagesModel> message;

  ChatSuccess({required this.message});
}
