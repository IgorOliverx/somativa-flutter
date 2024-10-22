import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tetse/interna.dart';

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
      body: TextButton(onPressed: () async {
        final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
        if(canAuthenticateWithBiometrics){
          final bool didAuthenticate = await auth.authenticate(
              localizedReason: 'Verifique a biometria para dar o cuzinho',
          options: const AuthenticationOptions(biometricOnly: false));
          if(didAuthenticate){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (contextNew) => const Interna()));
          }
        }
      }, child: const Text('Biometria')),
    );
  }
}
