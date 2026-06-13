import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, this.auth});

  final FirebaseAuth? auth;
  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

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
                "VERBUM",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
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
                onPressed: () async {
                  if (txtEmail.text.isEmpty || txtSenha.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, preencha todos os campos'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  try {
                    final firebaseAuth = auth ?? FirebaseAuth.instance;
                    await firebaseAuth.signInWithEmailAndPassword(
                      email: txtEmail.text,
                      password: txtSenha.text,
                    );
                    Navigator.pushReplacementNamed(context, '/difficulty');
                  } on FirebaseAuthException catch (ex) {
                    final snackBar = SnackBar(
                      content: Text(ex.message!),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text("ENTRAR NA MATRIX"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text(
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