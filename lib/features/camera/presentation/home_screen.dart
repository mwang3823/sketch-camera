import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'camera_preview_widget.dart';
import '../../overlay/presentation/overlay_image_widget.dart';
import '../../overlay/presentation/grid_painter.dart';
import '../../overlay/presentation/top_toolbar.dart';
import '../../overlay/presentation/bottom_toolbar.dart';
import '../../overlay/presentation/opacity_slider_widget.dart';
import '../../overlay/presentation/overlay_provider.dart';

/// The main canvas screen for Camera Trace drawing.
/// Organizes camera feed, overlay image gesture layers, and floating toolbars in a single Stack view.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayState = ref.watch(overlayProvider);
    final hasImage = overlayState.imagePath != null;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Bottom-most layer: Full-screen Live Camera Preview
          const CameraPreviewWidget(),

          // 2. Guidelines Grid overlay (with touch interactions disabled)
          if (overlayState.isGridVisible)
            const IgnorePointer(
              child: CustomPaint(
                painter: GridPainter(),
              ),
            ).animate().fadeIn(duration: 250.ms),

          // 3. Middle layer: Interactive reference overlay image layer
          const OverlayImageWidget(),

          // Empty state placeholder instructions when no image is loaded
          if (!hasImage)
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select a Trace Image',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap the gallery icon in the toolbar below to import a reference drawing.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white60,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 300.ms),

          // 4. Top-most layer: Safe area floating toolbars and opacity adjuster
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top-aligned Control Toolbar
                const TopToolbar()
                    .animate()
                    .fadeIn(duration: 250.ms)
                    .slideY(begin: -0.15, end: 0.0, curve: Curves.easeOutCubic),
                
                const Spacer(),

                // Floating real-time Opacity slider widget
                const OpacitySliderWidget()
                    .animate()
                    .fadeIn(duration: 200.ms)
                    .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
                
                const SizedBox(height: 8),

                // Bottom-aligned action controls toolbar
                const BottomToolbar()
                    .animate()
                    .fadeIn(duration: 250.ms)
                    .slideY(begin: 0.15, end: 0.0, curve: Curves.easeOutCubic),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
