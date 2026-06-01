import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OraclePage extends StatelessWidget {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void _adicionarAColecao(BuildContext context, Map<String, dynamic> data) async {
    try {
      await _db.collection('list_word').add({
        'palavra': data['palavra'],
        'significado': data['significado'],
        'dificuldade': data['dificuldade'],
        'userId': _auth.currentUser!.uid,
        'dataCriacao': DateTime.now(),
        'dataAtualizacao': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✓ Palavra adicionada à coleção!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            Text(
              "ANÁLISE IA",
              style: TextStyle(color: Colors.greenAccent, fontSize: 18),
            ),
            Text(
              "${data['porcentagem']}%",
              style: TextStyle(color: Colors.greenAccent, fontSize: 30),
            ),
            Text(
                'DICIONÁRIO: ${data['significado']}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent),
            ),
            Text(
                '"${data['feedback']}"',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent),
            ),
            ElevatedButton.icon(
              onPressed: () => _adicionarAColecao(context, data),
              icon: Icon(Icons.library_add),
              label: Text('Adicionar à Coleção'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.greenAccent),
              ),
              onPressed: () => Navigator.pushNamed(context, '/difficulty'),
              child: Text(
                "NOVO DESAFIO",
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}