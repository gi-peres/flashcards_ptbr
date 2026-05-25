import 'package:flutter/material.dart';

import 'widgets/matrix_button.dart';
import 'widgets/typing_text.dart';

class OraclePage extends StatelessWidget {
  const OraclePage({super.key});

  @override
  Widget build(BuildContext context) {

    final data =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, dynamic>;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const TypingText("ANÁLISE IA"),

            TypingText(
              "${data['porcentagem']}%",
              size: 30,
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'DICIONÁRIO: ${data['significado']}',
                style: const TextStyle(
                  color: Colors.greenAccent,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '"${data['feedback']}"',
                style: const TextStyle(
                  color: Colors.greenAccent,
                ),
              ),
            ),

            MatrixButton(
              "NOVO DESAFIO",
              () => Navigator.pushNamed(
                context,
                '/difficulty',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

