import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State model representing the camera feed configuration and controller state.
class CameraState {
  final bool isInitialized;
  final CameraController? controller;
  final List<CameraDescription> cameras;
  final int activeCameraIndex;
  final String? errorMessage;

  const CameraState({
    required this.isInitialized,
    this.controller,
    this.cameras = const [],
    this.activeCameraIndex = 0,
    this.errorMessage,
  });

  CameraState copyWith({
    bool? isInitialized,
    CameraController? controller,
    List<CameraDescription>? cameras,
    int? activeCameraIndex,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CameraState(
      isInitialized: isInitialized ?? this.isInitialized,
      controller: controller ?? this.controller,
      cameras: cameras ?? this.cameras,
      activeCameraIndex: activeCameraIndex ?? this.activeCameraIndex,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Notifier controlling camera list loading, initialization, lifecycle, and toggles.
class CameraNotifier extends StateNotifier<CameraState> with WidgetsBindingObserver {
  CameraNotifier() : super(const CameraState(isInitialized: false)) {
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  /// Finds and loads available cameras on the device.
  Future<void> _initialize() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        state = state.copyWith(errorMessage: 'No cameras detected on this device.');
        return;
      }
      state = state.copyWith(cameras: cameras, activeCameraIndex: 0);
      await _initController(cameras[0]);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to scan available cameras: $e');
    }
  }

  /// Initializes a specific camera controller. Disposes any existing controller first.
  Future<void> _initController(CameraDescription description) async {
    state = state.copyWith(isInitialized: false, errorMessage: null);

    final oldController = state.controller;
    if (oldController != null) {
      state = state.copyWith(controller: null);
      // Run async dispose in background or wait to avoid UI lag.
      await oldController.dispose();
    }

    final controller = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false, // We do not need audio for a drawing trace overlay app.
    );

    try {
      await controller.initialize();
      state = state.copyWith(
        isInitialized: true,
        controller: controller,
      );
    } catch (e) {
      state = state.copyWith(
        isInitialized: false,
        errorMessage: 'Could not connect to camera: $e',
      );
    }
  }

  /// Switches between the front and rear cameras (if multiple cameras are present).
  Future<void> toggleCamera() async {
    if (state.cameras.length < 2) return;
    
    final nextIndex = (state.activeCameraIndex + 1) % state.cameras.length;
    state = state.copyWith(activeCameraIndex: nextIndex);
    await _initController(state.cameras[nextIndex]);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (lifecycleState == AppLifecycleState.inactive ||
        lifecycleState == AppLifecycleState.paused) {
      final controller = state.controller;
      if (controller != null && state.isInitialized) {
        // Release camera hardware to the system when app goes to background
        state = state.copyWith(isInitialized: false, controller: null);
        controller.dispose();
      }
    } else if (lifecycleState == AppLifecycleState.resumed) {
      // Re-initialize camera feed on app resume
      if (state.cameras.isNotEmpty) {
        _initController(state.cameras[state.activeCameraIndex]);
      } else {
        _initialize();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    state.controller?.dispose();
    super.dispose();
  }
}

/// Provider for camera controller and lifecycle management.
final cameraProvider = StateNotifierProvider<CameraNotifier, CameraState>((ref) {
  final notifier = CameraNotifier();
  ref.onDispose(() {
    notifier.dispose();
  });
  return notifier;
});
