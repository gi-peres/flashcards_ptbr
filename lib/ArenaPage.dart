import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'widgets/matrix_input.dart';
import 'widgets/matrix_button.dart';

import 'gemini_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ArenaPage extends StatefulWidget {
  final String dificuldade;

  const ArenaPage({super.key, required this.dificuldade});

  @override
  State<ArenaPage> createState() => _ArenaPageState();
}

class _ArenaPageState extends State<ArenaPage> {
  final gemini = GeminiService();

  final respostaController = TextEditingController();

  String palavra = "";
  String significado = "";

  @override
  void initState() {
    super.initState();

    carregarPalavra();
  }

  Future<void> carregarPalavra() async {
    print("INICIOU");

    final resultado = await gemini.gerarPalavra(widget.dificuldade);

    print(resultado);

    setState(() {
      palavra = resultado['palavra'];
      significado = resultado['significado'];
    });
  }

  Future<void> enviarResposta() async {
    final analise = await gemini.analisarResposta(
      palavra: palavra,
      significadoReal: significado,
      respostaUsuario: respostaController.text,
    );

    if (!mounted) return;

    Navigator.pushNamed(
      context,
      '/oracle',
      arguments: {
        "porcentagem": analise["porcentagem"],
        "feedback": analise["feedback"],
        "significado": significado,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nome do escolhido ${_auth.currentUser?.displayName}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.greenAccent,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              palavra.isEmpty ? "CARREGANDO..." : palavra.toUpperCase(),
              style: const TextStyle(color: Colors.greenAccent, fontSize: 28),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: MatrixInput(
                "Digite o significado_",
                controller: respostaController,
              ),
            ),

            MatrixButton("SUBMETER AO ORÁCULO", enviarResposta),
          ],
        ),
      ),
    );
  }
}
