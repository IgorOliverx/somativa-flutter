import 'package:flutter/material.dart';

class ConfirmPresenceScreen extends StatelessWidget {
  const ConfirmPresenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.check, color: Colors.red),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Título "Confirme sua presença"
            const Text(
              'Confirme sua presença',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            // Card "Tudo a seu dispor"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Tudo a seu dispor',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Ícones da parte inferior
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.widgets, color: Colors.white, size: 32),
                      Icon(Icons.airplanemode_active, color: Colors.white, size: 32),
                      Icon(Icons.camera, color: Colors.white, size: 32),
                      Icon(Icons.anchor, color: Colors.white, size: 32),
                      Icon(Icons.adb, color: Colors.white, size: 32),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Seção de localização (com imagem do SENAI e o botão de "Check")
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://logodownload.org/wp-content/uploads/2014/12/senai-logo.png',
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: const Text('Check'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
