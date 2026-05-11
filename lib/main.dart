import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyDKFgs46Fo9_EmvaB9kxL5DDjKj5xlc-n0",
  authDomain: "verbum-c6495.firebaseapp.com",
  projectId: "verbum-c6495",
  storageBucket: "verbum-c6495.firebasestorage.app",
  messagingSenderId: "384540279800",
  appId: "1:384540279800:web:4ae79b4e8ae613aacb8c0d",
  measurementId: "G-25FWM1G0S9",
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: firebaseConfig,
  );

  runApp(const MyApp());
}

