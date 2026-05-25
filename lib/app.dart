import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'LoginPage.dart'; 
import 'DifficultyPage.dart';
import 'ArenaPage.dart';
import 'HelpPage.dart';
import 'OraclePage.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/difficulty': (_) => const DifficultyPage(),
        '/help': (_) => const HelpPage(),
        '/oracle': (_) => const OraclePage(),
      },
    );
  }
}