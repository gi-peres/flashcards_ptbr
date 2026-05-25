import 'package:flutter/material.dart';
import 'package:verbum_app/widgets/matrix_input.dart';
import 'package:verbum_app/widgets/matrix_button.dart';
import 'package:verbum_app/widgets/typing_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Future<void> fazerLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: senhaController.text.trim(),
      );

      Navigator.pushNamed(context, '/difficulty');
    } on FirebaseAuthException catch (e) {
      String erro = "Erro ao fazer login";

      if (e.code == 'user-not-found') {
        erro = "Usuário não encontrado";
      }

      if (e.code == 'wrong-password') {
        erro = "Senha incorreta";
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gifs/matrix.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TypingText("VERBUM", size: 32),

              MatrixInput("Email_", controller: emailController),

              MatrixInput(
                "Senha_",
                controller: senhaController,
                obscureText: true,
              ),

              MatrixButton("ENTRAR NA MATRIX", () => fazerLogin()),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text(
                  "CRIAR NOVO CADASTRO",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
