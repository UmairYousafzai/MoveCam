import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProviderNotifier extends StateNotifier<Map<Permission, bool>> {
  PermissionProviderNotifier()
      : super({
          Permission.camera: false,
          Permission.storage: false,
          Permission.location: false,
        }) {
    _checkAllPermissions();
  }

  Future<void> _checkAllPermissions() async {
    Map<Permission, bool> updatedPermissions = {};
    for (Permission permission in state.keys) {
      bool isGranted = await permission.isGranted;
      updatedPermissions[permission] = isGranted;
    }
    state = updatedPermissions;
  }

  void addPermission(Permission permission, bool status) {
    state = {...state, permission: status};
  }
}

final permissionProvider =
    StateNotifierProvider<PermissionProviderNotifier, Map<Permission, bool>>(
        (ref) => PermissionProviderNotifier());
