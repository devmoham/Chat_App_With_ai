import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app_ai/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItemWidget extends StatelessWidget {
  final ChatMessageModel message;
  const MessageItemWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formatedDate = DateFormat('hh:mm a').format(message.time);
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: message.isUser ? Colors.black : Colors.white,
          fontWeight: FontWeight.normal,
        );
    return Align(
      alignment: message.isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.85, // Ensure the max width is within screen
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (message.isUser) ...[
              CircleAvatar(
                radius: 16.0,
                child: Icon(Icons.person),
              ),
              SizedBox(width: 8.0),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: message.isUser
                            ? Colors.grey.shade200
                            : Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            topRight: message.isUser
                                ? Radius.circular(25)
                                : Radius.circular(0),
                            bottomLeft: message.isUser
                                ? Radius.circular(0)
                                : Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: message.isUser
                          ? Text(
                              message.text,
                              style: textStyle,
                            )
                          : AnimatedTextKit(
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  message.text,
                                  textStyle: textStyle,
                                ),
                              ],
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(formatedDate, style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
