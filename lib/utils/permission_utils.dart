import 'package:flutter_base/log/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionUtils {

 static setHasRequestPermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('has_requested_permission', true);
  }

 static Future<bool> hasRequestedPermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get('has_requested_permission');
  }
  static Future<void> requestPermission(
      PermissionGroup permission, String name) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
        await PermissionHandler().requestPermissions(permissions);

    Logger.d("permissions:$permissions,result:$permissionRequestResult");
    var _permissionStatus = permissionRequestResult[permission];

    if (_permissionStatus == PermissionStatus.granted) {
      //Fluttertoast.showToast(msg: "${name}权限申请通过");
    } else {
      Fluttertoast.showToast(msg: "${name}权限申请被拒绝");
    }
  }
}
