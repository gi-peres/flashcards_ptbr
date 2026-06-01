import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'gemini_service.dart';

class ArenaPage extends StatefulWidget {
  final String dificuldade;

  const ArenaPage({super.key, required this.dificuldade});

  @override
  State<ArenaPage> createState() => _ArenaPageState();
}

class _ArenaPageState extends State<ArenaPage> {
  final _auth = FirebaseAuth.instance;
  final gemini = GeminiService();
  final respostaController = TextEditingController();

  String palavra = "";
  String significado = "";

  @override
  void initState() {
    super.initState();
    carregarPalavra();
  }

  @override
  void dispose() {
    respostaController.dispose();
    super.dispose();
  }

  void carregarPalavra() async {
    final resultado = await gemini.gerarPalavra(widget.dificuldade);
    setState(() {
      palavra = resultado['palavra'];
      significado = resultado['significado'];
    });
  }

  void enviarResposta() async {
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
        "palavra": palavra,
        "dificuldade": widget.dificuldade,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decifre o código, ${_auth.currentUser?.displayName}'),
        foregroundColor: Colors.greenAccent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              palavra.isEmpty ? "CARREGANDO..." : palavra.toUpperCase(),
              style: TextStyle(color: Colors.greenAccent, fontSize: 28),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: respostaController,
                style: TextStyle(color: Colors.greenAccent),
                cursorColor: Colors.greenAccent,
                decoration: InputDecoration(
                  hintText: "Digite o significado_",
                  hintStyle: TextStyle(color: Colors.greenAccent),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.greenAccent),
              ),
              onPressed: enviarResposta,
              child: Text(
                "SUBMETER AO ORÁCULO",
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
