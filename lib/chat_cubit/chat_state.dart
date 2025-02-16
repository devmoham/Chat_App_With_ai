part of 'chat_cubit.dart';

sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<ChatMessageModel> messages;

  const ChatSuccess(this.messages);
}

final class ChatFailure extends ChatState {
  final String error;

  const ChatFailure(this.error);
}

final class SendingMessage extends ChatState {}

final class MessageSent extends ChatState {}

final class SendingMessageFailed extends ChatState {
  final String error;

  const SendingMessageFailed(this.error);
}

final class ImagePicked extends ChatState {
  final File image;

  const ImagePicked(this.image);
}

final class ImageRemoved extends ChatState {}