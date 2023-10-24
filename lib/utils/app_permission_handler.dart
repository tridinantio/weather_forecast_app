import 'package:permission_handler/permission_handler.dart';

class AppPermissionHandler {
  Future<bool?> getLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, you can now fetch the user's location
      return true;
    } else if (status.isDenied) {
      return false;
    }

    return false;
  }
}
