import 'package:flutter/material.dart';
import 'widgets/matrix_button.dart';
import 'widgets/typing_text.dart';

import 'widgets/matrix_rain.dart';

class DifficultyPage extends StatelessWidget {
  const DifficultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("login"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: [
          const MatrixRain(),
          
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TypingText("ESCOLHA DE DIFICULDADE"),
            MatrixButton("TRINITY",
                () => Navigator.pushNamed(context, '/arena'),
                color: Colors.green),
            MatrixButton("MORPHEUS",
                () => Navigator.pushNamed(context, '/arena'),
                color: Colors.yellow),
            MatrixButton("NEO",
                () => Navigator.pushNamed(context, '/arena'),
                color: Colors.red),
          ],
        ),
      ),
        ],
      ),
      
      
    );
  }
}