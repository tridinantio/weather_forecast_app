import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class GetLocation {
  Future<List<String>> fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      log(position.latitude.toString());

      return [position.latitude.toString(), position.longitude.toString()];
    } catch (e) {
      log("Error: $e");
    }

    return [];
  }
}
