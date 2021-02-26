import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid){
      var status = await Permission.storage.status;
      if (status.isUndetermined || status.isDenied || status.isPermanentlyDenied) {
        return false;
      }
    }
    return true;
  }

  Future<bool> getStoragePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    return statuses[Permission.storage].isGranted;
  }
}