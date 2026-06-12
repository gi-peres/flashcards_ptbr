import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'arena_page.dart';

class DifficultyPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Conexão estabelecida,\nEscolhido ${_auth.currentUser?.displayName}!',
          style: TextStyle(color: Colors.greenAccent),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.logout_outlined, color: Colors.greenAccent),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gifs/matrix.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ESCOLHA DE DIFICULDADE",
                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green),
                ),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArenaPage(dificuldade: "TRINITY"),
                      ),
                    ),
                child: Text("TRINITY", style: TextStyle(color: Colors.green)),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.yellow),
                ),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArenaPage(dificuldade: "MORPHEUS"),
                      ),
                    ),
                child: Text("MORPHEUS", style: TextStyle(color: Colors.yellow)),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                ),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArenaPage(dificuldade: "NEO"),
                      ),
                    ),
                child: Text("NEO", style: TextStyle(color: Colors.red)),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/collections'),
                icon: Icon(Icons.library_books),
                label: Text('Minhas Coleções'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
