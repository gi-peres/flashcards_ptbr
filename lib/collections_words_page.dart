import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ModalMode { adicionar, editar }

class CollectionsWordsPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  void _abrirModal(
    BuildContext context, {
    required ModalMode modo,
    String? id,
    String? palavra,
    String? significado,
    String? dificuldade,
  }) {
    final palavraController = TextEditingController(text: palavra ?? '');
    final significadoController = TextEditingController(text: significado ?? '');
    final dificuldadeController = TextEditingController(text: dificuldade ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(20, 24, 20,
            MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Text(
              modo == ModalMode.adicionar ? 'Nova Palavra' : 'Editar Palavra',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: palavraController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Palavra',
                labelStyle: TextStyle(color: Colors.greenAccent),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            TextField(
              controller: significadoController,
              style: TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Significado',
                labelStyle: TextStyle(color: Colors.greenAccent),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            TextField(
              controller: dificuldadeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Dificuldade (TRINITY, MORPHEUS, NEO)',
                labelStyle: TextStyle(color: Colors.greenAccent),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (modo == ModalMode.adicionar) {
                  _db.collection('list_word').add({
                    'palavra': palavraController.text,
                    'significado': significadoController.text,
                    'dificuldade': dificuldadeController.text,
                    'userId': _auth.currentUser!.uid,
                    'dataCriacao': DateTime.now(),
                    'dataAtualizacao': DateTime.now(),
                  });
                } else {
                  _db.collection('list_word').doc(id).update({
                    'palavra': palavraController.text,
                    'significado': significadoController.text,
                    'dificuldade': dificuldadeController.text,
                    'dataAtualizacao': DateTime.now(),
                  });
                }
                Navigator.pop(context);
              },
              child: Text(
                modo == ModalMode.adicionar ? 'ADICIONAR' : 'SALVAR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _corDificuldade(String dificuldade) {
    final cores = {
      'TRINITY': Colors.green,
      'MORPHEUS': Colors.orange,
      'NEO': Colors.red,
    };
    return cores[dificuldade.toUpperCase()] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Coleções'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.greenAccent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () => _abrirModal(context, modo: ModalMode.adicionar),
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _db
            .collection('list_word')
            .where('userId', isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, s) {
          if (!s.hasData) return CircularProgressIndicator();
          if (s.hasError) return Text(s.error.toString());

          final docs = s.data!.docs;

          return ListView(
            children: [
              for (var doc in docs)
                Dismissible(
                  key: Key(doc.id),
                  onDismissed: (_) => doc.reference.delete(),
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text(
                      doc['palavra'].toString().toUpperCase(),
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc['significado'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _corDificuldade(doc['dificuldade'] ?? '').withValues(alpha: 0.2),
                            border: Border.all(color: _corDificuldade(doc['dificuldade'] ?? '')),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (doc['dificuldade'] ?? '').toUpperCase(),
                            style: TextStyle(
                              color: _corDificuldade(doc['dificuldade'] ?? ''),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.greenAccent),
                      onPressed: () => _abrirModal(
                        context,
                        modo: ModalMode.editar,
                        id: doc.id,
                        palavra: doc['palavra'],
                        significado: doc['significado'],
                        dificuldade: doc['dificuldade'],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}