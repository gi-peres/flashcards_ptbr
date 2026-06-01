import 'package:flutter/material.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'difficulty_page.dart';
import 'oracle_page.dart';
import 'collections_words_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
        '/difficulty': (_) => DifficultyPage(),
        '/oracle': (_) => OraclePage(),
        '/collections': (_) => CollectionsWordsPage(),
      },
      initialRoute: '/login',
    );
  }
}
