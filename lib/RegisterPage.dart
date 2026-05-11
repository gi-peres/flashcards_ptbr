import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/matrix_input.dart';
import 'widgets/matrix_button.dart';
import 'widgets/typing_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> cadastrarUsuario() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: senhaController.text.trim(),
    );

    await userCredential.user?.updateDisplayName(
      nomeController.text.trim(),
    );

    await userCredential.user?.reload();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário criado com sucesso"),
        ),
      );

      Navigator.pop(context);
    }
  } on FirebaseAuthException catch (e) {
    if (mounted) {
      String erro = "Erro ao cadastrar";

      if (e.code == 'email-already-in-use') {
        erro = "Esse email já está cadastrado";
      }

      if (e.code == 'weak-password') {
        erro = "Senha muito fraca";
      }

      if (e.code == 'invalid-email') {
        erro = "Email inválido";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erro)),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TypingText("REGISTRO", size: 26),
            MatrixInput("Nome_", controller: nomeController),
            MatrixInput("Email_", controller: emailController),
            MatrixInput("Senha_", controller: senhaController, obscureText: true),
            MatrixButton("CADASTRAR", () => cadastrarUsuario()),
          ],
        ),
      ),
    );
  }
}
