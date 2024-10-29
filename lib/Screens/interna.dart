import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tetse/Screens/home.dart';

class ConfirmPresenceScreen extends StatelessWidget {
  ConfirmPresenceScreen({super.key});
  final LocalAuthentication auth = LocalAuthentication();

  // Coordenadas para a posição do prédio no senai
  double get latitude => -22.5711;
  double get longitude => -47.4040;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: Center(
          child: Text(
            'CheckIt!',
            textAlign: TextAlign.center,
          ),
        ),
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
                    // Adiciona o FlutterMap
                    Expanded(
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(latitude, longitude), // Centraliza o mapa
                          initialZoom: 16.0, // Nível de zoom
                          onTap: (tapPosition, latLng) {
                            // Ação ao tocar no mapa
                            print('Toque em: ${latLng.latitude}, ${latLng.longitude}');
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(latitude, longitude),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () async {
            final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
            if (canAuthenticateWithBiometrics) {
              final bool didAuthenticate = await auth.authenticate(
                localizedReason: 'Verifique a biometria para entrar no aplicativo',
                options: const AuthenticationOptions(biometricOnly: false),
              );
              if (didAuthenticate) {
                // Registro da presença no Firestore
                await FirebaseFirestore.instance.collection('presenca').add({
                  'presente': true, // Campo que indica presença
                  'timestamp': FieldValue.serverTimestamp(), // Adiciona um timestamp
                });

                // Navega para a próxima tela
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (contextNew) => const Home()),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          ),
          child: const Text('Check', style: TextStyle(color: Colors.white),),


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
