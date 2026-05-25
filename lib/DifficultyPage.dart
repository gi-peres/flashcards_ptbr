import 'package:flutter/material.dart';
import 'ArenaPage.dart';
import 'widgets/matrix_button.dart';
import 'widgets/typing_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class DifficultyPage extends StatelessWidget {
  const DifficultyPage({super.key});

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nome do escolhido ${_auth.currentUser?.displayName}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/gifs/matrix.gif', fit: BoxFit.cover),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TypingText("ESCOLHA DE DIFICULDADE"),
                MatrixButton(
                  "TRINITY",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ArenaPage(dificuldade: "TRINITY"),
                    ),
                  ),
                  color: Colors.green,
                ),
                MatrixButton(
                  "MORPHEUS",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ArenaPage(dificuldade: "MORPHEUS"),
                    ),
                  ),
                  color: Colors.yellow,
                ),
                MatrixButton(
                  "NEO",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ArenaPage(dificuldade: "NEO"),
                    ),
                  ),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
