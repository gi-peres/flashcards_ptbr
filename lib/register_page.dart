import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  final txtNome = TextEditingController();
  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

  Future registrar(BuildContext context) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: txtEmail.text,
            password: txtSenha.text,
          );

      await credential.user?.updateDisplayName(txtNome.text);

      txtNome.clear();
      txtEmail.clear();
      txtSenha.clear();

      Navigator.of(context)
      ..pop()
      ..pushReplacementNamed('/difficulty');
    } on FirebaseAuthException catch (e) {
      String erro = "Erro ao cadastrar";

      if (e.code == 'email-already-in-use') {
        erro = "Esse email já está cadastrado";
      }
      if (e.code == 'weak-password') erro = "Senha muito fraca";
      if (e.code == 'invalid-email') erro = "Email inválido";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erro), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gifs/matrix.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "REGISTRO",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: txtNome,
                style: TextStyle(color: Colors.greenAccent),
                cursorColor: Colors.greenAccent,
                decoration: InputDecoration(
                  hintText: "Nome_",
                  hintStyle: TextStyle(color: Colors.greenAccent),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
              ),
              TextField(
                controller: txtEmail,
                style: TextStyle(color: Colors.greenAccent),
                cursorColor: Colors.greenAccent,
                decoration: InputDecoration(
                  hintText: "Email_",
                  hintStyle: TextStyle(color: Colors.greenAccent),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
              ),
              TextField(
                controller: txtSenha,
                obscureText: true,
                style: TextStyle(color: Colors.greenAccent),
                cursorColor: Colors.greenAccent,
                decoration: InputDecoration(
                  hintText: "Senha_",
                  hintStyle: TextStyle(color: Colors.greenAccent),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => registrar(context),
                child: Text("CADASTRAR"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "VOLTAR",
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
