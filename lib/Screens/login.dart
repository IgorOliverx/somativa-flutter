import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tetse/Controller/LocationChecker.dart';
import 'package:tetse/Screens/interna.dart';
import 'package:tetse/Services/AccessService.dart';
import 'package:tetse/Services/AuthService.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  final AuthService _authService = AuthService();
  final AccessService _accessLogService = AccessService();

  // Função para autenticação via login no firebase
  Future<void> _authenticateAndLogin() async {
    LocationChecker locationChecker = LocationChecker();
    bool isInRestrictedArea = await locationChecker.isWithInRestrictedArea();
    print("Area restrita: $isInRestrictedArea");
    if (isInRestrictedArea) {
      try {
        User? isAuthenticated = await _authService.login(
          _emailController.text,
          _passwordController.text,
        );
        if (isAuthenticated != null) {
          await _accessLogService.registrarAcesso(true); // Acesso permitido
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ConfirmPresenceScreen()),
          );
        } else {
          setState(() {
            _errorMessage = 'Autenticação falhou.';
          });
          await _accessLogService.registrarAcesso(false); // Falha no Login
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Você não está na área restrita.';
      });
      await _accessLogService.registrarAcesso(false); // Acesso negado pela localização
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.red, // Cor de fundo azul escuro
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Campo de texto para o usuário
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white), // Texto branco
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1C3A57), // Fundo azul escuro
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.white), // Texto do label em branco
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // Remove a borda
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de texto para a senha
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white), // Texto branco
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1C3A57), // Fundo azul escuro
                labelText: 'Senha do Usuario',
                labelStyle: const TextStyle(color: Colors.white), // Texto do label em branco
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // Remove a borda
                ),
              ),
            ),
            const SizedBox(height: 40), // Espaço antes do botão de login

            // Botão de login
            ElevatedButton(
              onPressed: _authenticateAndLogin,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.blue, // Cor do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Fazer Login',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
