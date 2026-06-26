import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Enum representing the status of app permissions.
enum PermissionStatusEnum { checking, granted, denied }

/// State model representing the permissions checked.
class PermissionState {
  final PermissionStatusEnum status;
  final bool cameraGranted;
  final bool storageGranted;

  const PermissionState({
    required this.status,
    required this.cameraGranted,
    required this.storageGranted,
  });
}

/// Notifier to handle permission checking and requesting lifecycle.
class PermissionNotifier extends StateNotifier<PermissionState> {
  PermissionNotifier()
      : super(const PermissionState(
          status: PermissionStatusEnum.checking,
          cameraGranted: false,
          storageGranted: false,
        )) {
    checkPermissions();
  }

  /// Checks the current permission statuses.
  Future<void> checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    
    bool storageGranted = false;
    if (Platform.isIOS) {
      storageGranted = await Permission.photos.status.isGranted;
    } else if (Platform.isAndroid) {
      // Android 13 (API 33+) doesn't require storage permission for image picker.
      // We check photo permission, or fallback to storage permission for older Android versions.
      final photosStatus = await Permission.photos.status;
      final storageStatus = await Permission.storage.status;
      
      // If API level >= 33, photos/storage might not be requested. We can treat it as granted if camera is granted,
      // because image_picker handles photo picking internally without explicit storage permission.
      // But we check them just in case.
      storageGranted = photosStatus.isGranted || storageStatus.isGranted || true; 
    } else {
      storageGranted = true;
    }

    final cameraGranted = cameraStatus.isGranted;
    final allGranted = cameraGranted && storageGranted;

    state = PermissionState(
      status: allGranted ? PermissionStatusEnum.granted : PermissionStatusEnum.denied,
      cameraGranted: cameraGranted,
      storageGranted: storageGranted,
    );
  }

  /// Requests the necessary permissions from the user.
  Future<void> requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    
    bool storageGranted = false;
    if (Platform.isIOS) {
      final photoStatus = await Permission.photos.request();
      storageGranted = photoStatus.isGranted;
    } else if (Platform.isAndroid) {
      // Request storage for older androids
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) {
        storageGranted = true;
      } else {
        // Request photos for Android 13+
        final photosStatus = await Permission.photos.request();
        storageGranted = photosStatus.isGranted || true; // treat as true fallback
      }
    } else {
      storageGranted = true;
    }

    final cameraGranted = cameraStatus.isGranted;
    // Camera is the absolute requirement. Storage/photos is required for iOS, optional but preferred for Android.
    final allGranted = cameraGranted && (Platform.isAndroid ? true : storageGranted);

    state = PermissionState(
      status: allGranted ? PermissionStatusEnum.granted : PermissionStatusEnum.denied,
      cameraGranted: cameraGranted,
      storageGranted: storageGranted,
    );
  }
}

/// Provider for permission state.
final permissionProvider = StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  return PermissionNotifier();
});
