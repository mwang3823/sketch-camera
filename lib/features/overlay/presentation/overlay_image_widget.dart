import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
import 'overlay_provider.dart';

/// Interactive image overlay widget that handles user touch gestures (pan, scale, rotate).
/// Prevents modifications and shows lock indicator status when the overlay configuration is locked.
class OverlayImageWidget extends ConsumerStatefulWidget {
  const OverlayImageWidget({super.key});

  @override
  ConsumerState<OverlayImageWidget> createState() => _OverlayImageWidgetState();
}

class _OverlayImageWidgetState extends ConsumerState<OverlayImageWidget> {
  // Temporal gesture start params
  double _startScale = 1.0;
  double _startRotation = 0.0;
  double _startTranslationX = 0.0;
  double _startTranslationY = 0.0;
  Offset _startFocalPoint = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final overlayState = ref.watch(overlayProvider);
    final notifier = ref.read(overlayProvider.notifier);

    if (overlayState.imagePath == null) {
      return const SizedBox.shrink();
    }

    final double flipX = overlayState.isFlippedHorizontal ? -1.0 : 1.0;
    final double flipY = overlayState.isFlippedVertical ? -1.0 : 1.0;

    return Stack(
      children: [
        // Main Gesture Detection Layer
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onScaleStart: (details) {
              if (overlayState.isLocked) return;
              _startScale = overlayState.scale;
              _startRotation = overlayState.rotation;
              _startTranslationX = overlayState.translationX;
              _startTranslationY = overlayState.translationY;
              _startFocalPoint = details.localFocalPoint;
            },
            onScaleUpdate: (details) {
              if (overlayState.isLocked) return;

              // 1. Calculate Drag Translation Delta
              final offsetDelta = details.localFocalPoint - _startFocalPoint;
              final double newTx = _startTranslationX + offsetDelta.dx;
              final double newTy = _startTranslationY + offsetDelta.dy;

              // 2. Calculate Pinch Scale
              double newScale = _startScale * details.scale;
              // Bounds limits to prevent infinite or negative scaling
              newScale = newScale.clamp(0.05, 15.0);

              // 3. Calculate Two-finger Rotation
              final double newRotation = _startRotation + details.rotation;

              notifier.updateTransform(
                scale: newScale,
                rotation: newRotation,
                translationX: newTx,
                translationY: newTy,
              );
            },
            onDoubleTap: () {
              if (overlayState.isLocked) return;
              notifier.reset();
            },
            onLongPress: () {
              notifier.toggleLock();
              // Provide visual feedback for locking
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    overlayState.isLocked ? 'Overlay Unlocked!' : 'Overlay Locked!',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  behavior: SnackBarBehavior.floating,
                  width: 200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  duration: const Duration(milliseconds: 900),
                ),
              );
            },
            child: Stack(
              children: [
                // Rendered Image transformed based on state offsets
                Positioned.fill(
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.compose(
                        vm.Vector3(overlayState.translationX, overlayState.translationY, 0.0),
                        vm.Quaternion.axisAngle(vm.Vector3(0.0, 0.0, 1.0), overlayState.rotation),
                        vm.Vector3(overlayState.scale * flipX, overlayState.scale * flipY, 1.0),
                      ),
                      child: Opacity(
                        opacity: overlayState.opacity,
                        child: _buildFilteredImage(overlayState),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Floating Lock Indicator Badge
        if (overlayState.isLocked)
          Positioned(
            top: 100,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.orangeAccent.withValues(alpha: 0.4),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_rounded,
                    color: Colors.orangeAccent,
                    size: 15,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'LOCKED',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        // Floating loading indicator for outline edge generation isolate
        if (overlayState.isProcessing)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Extracting outlines...',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the image widget, applying either BoxFit.contain or BoxFit.cover
  /// and GPU-accelerated ColorFiltered matrices for grayscale, invert, and high contrast filters.
  Widget _buildFilteredImage(dynamic overlayState) {
    final bool useOutline = (overlayState.filterMode == OverlayFilterMode.outlineWhite ||
            overlayState.filterMode == OverlayFilterMode.outlineBlack ||
            overlayState.filterMode == OverlayFilterMode.outlineRed) &&
        overlayState.processedImagePath != null;
    
    final File imageFile = File(useOutline
        ? overlayState.processedImagePath!
        : overlayState.imagePath!);

    final doubleBoxFit = overlayState.fitMode == OverlayFitMode.contain
        ? BoxFit.contain
        : BoxFit.cover;

    final imageWidget = Image.file(
      imageFile,
      fit: doubleBoxFit,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image_outlined,
                color: Colors.redAccent,
                size: 48,
              ),
              SizedBox(height: 8),
              Text(
                'Failed to load trace image',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );

    // Apply color filter matrices or modes depending on filter mode
    ColorFilter? colorFilter;
    switch (overlayState.filterMode) {
      case OverlayFilterMode.grayscale:
        colorFilter = const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0,      0,      0,      1, 0,
        ]);
        break;
      case OverlayFilterMode.invert:
        colorFilter = const ColorFilter.matrix(<double>[
          -1,  0,  0, 0, 255,
           0, -1,  0, 0, 255,
           0,  0, -1, 0, 255,
           0,  0,  0, 1,   0,
        ]);
        break;
      case OverlayFilterMode.highContrast:
        colorFilter = const ColorFilter.matrix(<double>[
          1.06, 3.58, 0.36, 0, -250,
          1.06, 3.58, 0.36, 0, -250,
          1.06, 3.58, 0.36, 0, -250,
          0,    0,    0,    1, 0,
        ]);
        break;
      case OverlayFilterMode.outlineBlack:
        colorFilter = const ColorFilter.mode(Colors.black, BlendMode.srcIn);
        break;
      case OverlayFilterMode.outlineRed:
        colorFilter = const ColorFilter.mode(Colors.red, BlendMode.srcIn);
        break;
      case OverlayFilterMode.tintCyan:
        colorFilter = const ColorFilter.mode(Colors.cyan, BlendMode.color);
        break;
      case OverlayFilterMode.tintAmber:
        colorFilter = const ColorFilter.mode(Colors.amber, BlendMode.color);
        break;
      default:
        colorFilter = null;
    }

    if (colorFilter != null) {
      return ColorFiltered(
        colorFilter: colorFilter,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
