import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetse/Screens/home.dart';
import 'package:tetse/Screens/login.dart'; // Certifique-se de que a tela Home está importada corretamente

class PreHome extends StatefulWidget {
  const PreHome({Key? key}) : super(key: key);

  @override
  State<PreHome> createState() => _PreHomeState();
}

class _PreHomeState extends State<PreHome> {
  @override
  void initState() {
    super.initState();
    // Aguarda o primeiro frame para garantir que o contexto está disponível
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const AuthScreen(),
            transitionsBuilder: (context, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            },
            transitionDuration: const Duration(seconds: 1),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red, // Cor de fundo igual à da imagem
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CheckIt!',
                  style: TextStyle(
                    fontSize: 40, // Aumenta o tamanho do texto
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10), // Espaço entre o texto e o ícone
                Icon(
                  Icons.check_circle_outline, // Um ícone de checklist similar
                  size: 80, // Diminui o tamanho do ícone
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 20), // Espaço entre o ícone e o botão
          ],
        ),
      ),
    );
  }
}
