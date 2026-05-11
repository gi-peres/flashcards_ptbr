import 'package:flutter/material.dart';

class MatrixInput extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;

  const MatrixInput(this.hint, {super.key, this.controller, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.greenAccent),
        cursorColor: Colors.greenAccent,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.greenAccent),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }
}