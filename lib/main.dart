import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Adicione esta linha
import 'package:tetse/Screens/pre-home.dart';
import 'Screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Firebase seja inicializado corretamente
  await Firebase.initializeApp();            // Inicializa o Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreHome(),
    );
  }
}
