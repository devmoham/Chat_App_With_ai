import 'package:chat_app_ai/models/message_model.dart';
import 'package:chat_app_ai/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final chatServices = ChatServices();
  final List<ChatMessageModel> chatMessages = [];

  void startChatSession() {
    chatServices.startChatSession();
  }

  Future<void> sendMessage(String message) async {
    emit(SendingMessage());
    try {
      chatMessages
          .add(ChatMessageModel(text: message, time: DateTime.now(), isUser: true));
      emit(ChatSuccess(messages: chatMessages));

      final response = await chatServices.sendMessage(message);
      chatMessages.add(ChatMessageModel(
          text: response ?? 'Not response from ai',
          time: DateTime.now(),
          isUser: false));
      emit(MessageSent());
      emit(ChatSuccess(messages: chatMessages));
    } catch (e) {
      emit(SendingMessageError(e.toString()));
    }
  }
}
