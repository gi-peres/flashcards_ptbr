import 'package:flutter/material.dart';
import 'widgets/matrix_button.dart';
import 'widgets/typing_text.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TypingText("HELP ACTIVE"),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '"O céu cinzento deixava o vilarejo com um ar sorumbático."',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
            MatrixButton("VOLTAR", () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}