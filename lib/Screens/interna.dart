import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tetse/Screens/home.dart';

class ConfirmPresenceScreen extends StatefulWidget {
  ConfirmPresenceScreen({super.key});

  @override
  _ConfirmPresenceScreenState createState() => _ConfirmPresenceScreenState();
}

class _ConfirmPresenceScreenState extends State<ConfirmPresenceScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isPresentConfirmed = false; // Variável para controlar a confirmação

  // Coordenadas para a posição do prédio no SENAI
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
            const Text(
              'Confirme sua presença',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
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
                    Expanded(
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(latitude, longitude),
                          initialZoom: 16.0,
                          onTap: (tapPosition, latLng) {
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

                    // Botão "Check" visível apenas se a presença não foi confirmada
                    if (!_isPresentConfirmed)
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
                                'presente': true,
                                'timestamp': FieldValue.serverTimestamp(),
                              });

                              // Atualizar o estado para indicar que a presença foi confirmada
                              setState(() {
                                _isPresentConfirmed = true;
                              });

                              // Exibir um diálogo de confirmação
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmação'),
                                    content: const Text('Presença confirmada com sucesso!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
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
                        child: const Text('Check', style: TextStyle(color: Colors.white)),
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
