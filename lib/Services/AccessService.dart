import 'package:geolocator/geolocator.dart';
import 'package:tetse/Controller/AccessController.dart';
import 'package:tetse/Model/access.dart';

class AccessService {
  Future<void> registrarAcesso (bool acesso) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    DateTime now = DateTime.now();


    Access log = Access(
      id: '',
      access: acesso,
      timestamp: now,
      latitude: position.latitude,
      longitude: position.longitude,
    );

    AccessController controller = AccessController();
    await controller.addLog(log);
  }
}