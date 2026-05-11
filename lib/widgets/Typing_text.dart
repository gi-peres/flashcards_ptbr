import 'dart:async';
import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final String text;
  final double size;

  const TypingText(this.text, {this.size = 18, super.key});

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String display = '';
  int i = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (i < widget.text.length) {
        setState(() {
          display += widget.text[i];
          i++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      display,
      style: TextStyle(color: Colors.greenAccent, fontSize: widget.size),
    );
  }
}