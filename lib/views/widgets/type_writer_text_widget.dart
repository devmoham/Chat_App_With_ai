import 'package:flutter/material.dart';
class TypewriterText extends StatefulWidget {
  final String text;
  const TypewriterText({required this.text, Key? key}) : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  @override
  Widget build(BuildContext context) {
    
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: widget.text.length),
      duration: Duration(seconds: 2),
      builder: (context, value, child) {
        return Text(widget.text.substring(0, value),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
      },
    );
  }
}
