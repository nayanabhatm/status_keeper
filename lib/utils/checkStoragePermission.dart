import 'package:permission_handler/permission_handler.dart';
import 'package:statuskeeper/utils/constants.dart';

class PermissionCheck {
  static Future<String> checkStoragePermission() async {
    var permission = await Permission.storage.status;

    if (permission.isDenied) {
      await Permission.storage.request();
      if (permission.isPermanentlyDenied) {
        return Constants.permissionPermanentlyDenied;
      }

      if (permission.isDenied) {
        return Constants.permissionDenied;
      }
    }
    return Constants.permissionGranted;
  }
}
