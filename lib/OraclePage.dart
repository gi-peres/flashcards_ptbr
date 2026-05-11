import 'package:flutter/material.dart';
import 'widgets/matrix_button.dart';
import 'widgets/typing_text.dart';

class OraclePage extends StatelessWidget {
  const OraclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TypingText("ANÁLISE IA"),
            const TypingText("88%", size: 30),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'DICIONÁRIO: tristeza, melancólico',
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '"Excelente conexão"',
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
            MatrixButton("NOVO DESAFIO",
                () => Navigator.pushNamed(context, '/arena')),
          ],
        ),
      ),
    );
  }
}