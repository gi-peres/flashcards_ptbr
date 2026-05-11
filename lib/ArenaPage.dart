import 'package:flutter/material.dart';
import 'widgets/matrix_input.dart';
import 'widgets/matrix_button.dart';
import 'widgets/typing_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ArenaPage extends StatelessWidget {
  const ArenaPage({super.key});

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _auth.currentUser?.displayName ?? 'Usuário';
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Nome do escolhido $displayName'),
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/difficulty');
          },
        ),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: Colors.black,
        foregroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TypingText("SORUMBÁTICO", size: 28),
            const MatrixInput("Digite o significado_"),
            MatrixButton("SUBMETER AO ORÁCULO",
                () => Navigator.pushNamed(context, '/oracle')),
            MatrixButton("PEDIR AJUDA",
                () => Navigator.pushNamed(context, '/help')),
          ],
        ),
      ),
    );
  }
}