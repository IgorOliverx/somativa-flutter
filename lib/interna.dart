import 'package:flutter/material.dart';

class Interna extends StatefulWidget {
  const Interna({super.key});

  @override
  State<Interna> createState() => _InternaState();
}

class _InternaState extends State<Interna> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Seja bem vindo a pagina interna'),
      ),
    );
  }
}
