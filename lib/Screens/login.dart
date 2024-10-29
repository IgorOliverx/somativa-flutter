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
  String? _emailError;
  String? _passwordError;

  final AuthService _authService = AuthService();
  final AccessService _accessLogService = AccessService();

  Future<void> _authenticateAndLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
      _errorMessage = null;
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        if (_emailController.text.isEmpty) {
          _emailError = 'Por favor, preencha o campo de email.';
        }
        if (_passwordController.text.isEmpty) {
          _passwordError = 'Por favor, preencha o campo de senha.';
        }
      });
      return;
    }

    LocationChecker locationChecker = LocationChecker();
    bool isInRestrictedArea = await locationChecker.isWithInRestrictedArea();
    print("Área restrita: $isInRestrictedArea");
    if (isInRestrictedArea) {
      try {
        User? isAuthenticated = await _authService.login(
          _emailController.text,
          _passwordController.text,
        );
        if (isAuthenticated != null) {
          await _accessLogService.registrarAcesso(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ConfirmPresenceScreen()),
          );
        } else {
          setState(() {
            _errorMessage = 'Autenticação falhou.';
            _emailError = 'Email ou senha incorretos.';
            _passwordError = 'Email ou senha incorretos.';
          });
          await _accessLogService.registrarAcesso(false);
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
      await _accessLogService.registrarAcesso(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Campo de texto para o usuário
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                errorText: _emailError,
                errorStyle: const TextStyle(color: Colors.yellow), // Cor da mensagem de erro
              ),
            ),
            const SizedBox(height: 16),

            // Campo de texto para a senha
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                labelText: 'Senha',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                errorText: _passwordError,
                errorStyle: const TextStyle(color: Colors.yellow), // Cor da mensagem de erro
              ),
            ),
            const SizedBox(height: 40),

            // Botão de login
            ElevatedButton(
              onPressed: _authenticateAndLogin,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.blue,
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
                style: const TextStyle(color: Colors.yellow), // Cor da mensagem de erro
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}