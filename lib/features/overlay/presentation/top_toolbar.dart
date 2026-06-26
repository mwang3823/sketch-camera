import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'overlay_provider.dart';
import '../../../shared/widgets/floating_icon_button.dart';

/// Top toolbar widget that floats at the top.
/// Displays file details if an image is loaded, alongside clear and instructions modals.
class TopToolbar extends ConsumerWidget {
  const TopToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayState = ref.watch(overlayProvider);
    final notifier = ref.read(overlayProvider.notifier);

    // Dynamic toolbar title representing file name or app name
    String titleText = 'Camera Trace';
    if (overlayState.imagePath != null) {
      try {
        titleText = overlayState.imagePath!.split('/').last;
      } catch (_) {
        titleText = 'Reference Image';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              children: [
                // Clear active trace image
                if (overlayState.imagePath != null)
                  FloatingIconButton(
                    icon: Icons.close_rounded,
                    tooltip: 'Clear Reference Image',
                    onPressed: () {
                      notifier.clearImage();
                    },
                  )
                else
                  const SizedBox(width: 48), // Padding balance to center title
                
                const Spacer(),
                
                // Active Title Info
                Expanded(
                  child: Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const Spacer(),
                
                // Settings info dialog trigger
                FloatingIconButton(
                  icon: Icons.help_outline_rounded,
                  tooltip: 'App Instructions',
                  onPressed: () {
                    _showInfoDialog(context, ref);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.brush_outlined, color: Colors.blue),
              SizedBox(width: 10),
              Text(
                'Trace Instructions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'Secure your phone above your drawing paper, align the image overlay over the camera feed, and start tracing!\n\n'
            'Gestures Checklist:\n'
            '• 1 Finger Drag: Translate image.\n'
            '• 2 Finger Pinch: Zoom and scale.\n'
            '• 2 Finger Twist: Rotate image.\n'
            '• Double-Tap: Reset trace alignments.\n'
            '• Long Press: Lock/Unlock movements.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(overlayProvider.notifier).reset();
                Navigator.of(context).pop();
              },
              child: const Text('Reset Alignment'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Dismiss',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
