import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'camera_provider.dart';
import '../../../shared/widgets/loading_view.dart';
import '../../../shared/widgets/error_view.dart';

/// Full screen camera preview widget.
/// Correctly scales and clips the preview to match the device aspect ratio without stretching.
class CameraPreviewWidget extends ConsumerWidget {
  const CameraPreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraState = ref.watch(cameraProvider);

    if (cameraState.errorMessage != null) {
      return ErrorView(
        message: cameraState.errorMessage!,
        onRetry: () {
          // Re-triggering initialization by invalidating the provider
          ref.invalidate(cameraProvider);
        },
      );
    }

    if (!cameraState.isInitialized || cameraState.controller == null) {
      return const LoadingView(message: 'Starting Camera...');
    }

    final controller = cameraState.controller!;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate scale to make the preview fill the entire screen (BoxFit.cover equivalent)
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Camera aspect ratio is previewWidth / previewHeight.
        // The camera package returns aspect ratio in landscape mode by default,
        // so in portrait mode, the preview aspect ratio is height / width.
        double cameraRatio = controller.value.aspectRatio;
        
        // Adjust for portrait orientation:
        final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
        if (isPortrait) {
          cameraRatio = 1.0 / cameraRatio;
        }

        final screenRatio = screenWidth / screenHeight;

        // Scale factors to achieve "cover" fit
        double scale = 1.0;
        if (isPortrait) {
          if (cameraRatio < screenRatio) {
            scale = screenRatio / cameraRatio;
          } else {
            scale = cameraRatio / screenRatio;
          }
        } else {
          if (cameraRatio > screenRatio) {
            scale = cameraRatio / screenRatio;
          } else {
            scale = screenRatio / cameraRatio;
          }
        }

        return ClipRect(
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.center,
            child: Center(
              child: CameraPreview(controller),
            ),
          ),
        );
      },
    );
  }
}
