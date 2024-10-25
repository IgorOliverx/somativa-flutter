import 'package:geolocator/geolocator.dart';

class LocationChecker{
  // Defina as coordenadas da área restrita
  final double restrictedAreaLatitude = -22.5711;
  final double restrictedAreaLongitude = -47.4040;
  final double allowedRadiusInMeters = 30; //Raio de 30 metros para permitir a presença somente na área delimitada


  Future<bool> isWithInRestrictedArea() async {
    try{

      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        permission = await Geolocator.requestPermission();
      }
      if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


        double distancia = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          restrictedAreaLatitude,
          restrictedAreaLongitude,
        );


        return distancia <= allowedRadiusInMeters;
      }
      return false;
    }catch(e){
       print("Erro ao verificar localização: $e");
      return false;
    }
  }
}