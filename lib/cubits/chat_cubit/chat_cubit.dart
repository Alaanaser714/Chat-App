import 'package:bloc/bloc.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  void sendMessage({required String data, required String email}) {
    messages.add(
      {'messages': data, "time": DateTime.now(), "id": email},
    );
  }

  void getMessage() {
    messages.orderBy("time", descending: true).snapshots().listen((event) {
      List<MessagesModel> messageList = [];

      for (var doc in event.docs) {
        messageList.add(MessagesModel.fromJson(doc));
      }
      emit(ChatSuccess(message: messageList));
    });
  }
}