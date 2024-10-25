import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tetse/Screens/interna.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Cor de fundo igual à da imagem
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // O texto "CheckIt!" estilizado
            const Text(
              'CheckIt!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10), // Espaço entre o texto e o ícone
            // O ícone de checklist estilizado
            const Icon(
              Icons.check_circle_outline, // Um ícone de checklist similar
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20), // Espaço entre o ícone e o botão
            ElevatedButton(
              onPressed: () async {
                final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
                if (canAuthenticateWithBiometrics) {
                  final bool didAuthenticate = await auth.authenticate(
                    localizedReason: 'Verifique a biometria para entrar no aplicativo',
                    options: const AuthenticationOptions(biometricOnly: false),
                  );
                  if (didAuthenticate) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (contextNew) =>  ConfirmPresenceScreen()),
                    );
                  }
                }
              },
              child: const Text('Acessar o App'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
