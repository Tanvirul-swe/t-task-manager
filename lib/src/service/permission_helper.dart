import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  // Get Ios storage read write permission for create sqlite database
  static Future<bool> getPermission() async {
    if (Platform.isIOS) {
      final PermissionStatus permission = await Permission.storage.status;
      if (permission != PermissionStatus.granted) {
        final Map<Permission, PermissionStatus> permissionStatus =
            await [Permission.storage].request();
        return permissionStatus[Permission.storage] == PermissionStatus.granted;
      }
      return false;
    } else if (Platform.isAndroid) {
      final Map<Permission, PermissionStatus> status = await [
      Permission.storage,
      Permission.photos,

        
      ].request();
      return status[Permission.storage] == PermissionStatus.granted;
    }
    return false;
  }
}
