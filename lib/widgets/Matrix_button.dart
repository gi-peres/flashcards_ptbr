import 'package:flutter/material.dart';

class MatrixButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const MatrixButton(this.text, this.onPressed,
      {this.color = Colors.greenAccent, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: color)),
      ),
    );
  }
}