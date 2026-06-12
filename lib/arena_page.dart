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

  Color get corDificuldade {
    switch (widget.dificuldade) {
      case "TRINITY":
        return Colors.green;

      case "MORPHEUS":
        return Colors.yellow;

      case "NEO":
        return Colors.red;

      default:
        return Colors.greenAccent;
    }
  }

  @override
  void initState() {
    super.initState();
    carregarPalavra();
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
        foregroundColor: corDificuldade,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              palavra.isEmpty ? "CARREGANDO..." : palavra.toUpperCase(),
              style: TextStyle(color: corDificuldade, fontSize: 28),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: respostaController,
                style: TextStyle(color: corDificuldade),
                cursorColor: corDificuldade,
                decoration: InputDecoration(
                  hintText: "Digite o significado_",
                  hintStyle: TextStyle(color: corDificuldade),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: corDificuldade),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: corDificuldade),
                  ),
                ),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: corDificuldade),
              ),
              onPressed: enviarResposta,
              child: Text(
                "SUBMETER AO ORÁCULO",
                style: TextStyle(color: corDificuldade),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
