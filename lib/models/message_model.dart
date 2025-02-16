import 'dart:convert';
import 'dart:io';

class ChatMessageModel {
  final String text;
  final File? image;
  final DateTime time;
  final bool isUser;

  ChatMessageModel({
    required this.text,
    required this.time,
    required this.isUser,
     this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': text,
      'time': time,
      'isUser': isUser,
      'image': image,
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      text: map['message'] as String,
      time: map['time'] as DateTime,
      isUser: map['isUser'] as bool,
      image: map['image'] as File,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageModel.fromJson(String source) =>
      ChatMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
