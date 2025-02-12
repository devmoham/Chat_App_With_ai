part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

// User
final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<ChatMessageModel> messages;
  ChatSuccess({required this.messages});
}

final class ChatFailure extends ChatState {
  final String error;
  ChatFailure(this.error);
}

// Ai
final class SendingMessage extends ChatState {}

final class MessageSent extends ChatState {}

final class SendingMessageError extends ChatState {
  final String error;
  SendingMessageError(this.error);
}
