import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

class CurrentLocation {
  LocationData? currentLocation;

  // Constructor que recibe la ubicación
  CurrentLocation(this.currentLocation);

  Future<String> getAddressFromCurrentLocation() async {
    try {
      if (currentLocation != null) {
        double currentLatitude = currentLocation!.latitude!;
        double currentLongitude = currentLocation!.longitude!;

        print('Ubicación del usuario: $currentLatitude, $currentLongitude');

        List<Placemark> placemarks = await placemarkFromCoordinates(currentLatitude, currentLongitude);

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          String formattedAddress = '${placemark.street}, ${placemark.locality}, ${placemark.country}';
          return formattedAddress;
        } else {
          return 'Dirección no encontrada';
        }
      } else {
        return 'Ubicación no disponible';
      }
    } catch (e) {
      print('Error al obtener la dirección: $e');
      return 'Error al obtener la dirección';
    }
  }
}