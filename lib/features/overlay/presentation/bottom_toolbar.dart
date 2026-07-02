import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'overlay_provider.dart';
import '../../camera/presentation/camera_provider.dart';
import '../../../shared/widgets/floating_icon_button.dart';

/// Floating control bar at the bottom containing import, mirror, grid, lock, and reset commands.
class BottomToolbar extends ConsumerWidget {
  const BottomToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayState = ref.watch(overlayProvider);
    final overlayNotifier = ref.read(overlayProvider.notifier);
    final cameraState = ref.watch(cameraProvider);
    final cameraNotifier = ref.read(cameraProvider.notifier);

    final hasImage = overlayState.imagePath != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. Import from Gallery Button
                    FloatingIconButton(
                      icon: Icons.photo_library_outlined,
                      tooltip: 'Import Reference Image',
                      onPressed: () {
                        if (overlayState.imageHistory.isEmpty) {
                          overlayNotifier.pickImage();
                        } else {
                          _showHistoryBottomSheet(context);
                        }
                      },
                    ),
                    const SizedBox(width: 8),

                    // 2. Camera Toggle Front/Rear Button
                    if (cameraState.cameras.length > 1) ...[
                      FloatingIconButton(
                        icon: Icons.flip_camera_ios_outlined,
                        tooltip: 'Switch Camera',
                        onPressed: () => cameraNotifier.toggleCamera(),
                      ),
                      const SizedBox(width: 8),
                    ],

                    // Visual vertical divider
                    if (hasImage) ...[
                      Container(
                        height: 28,
                        width: 1,
                        color: Colors.white12,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                      ),

                      // Clear Reference Image Button
                      FloatingIconButton(
                        icon: Icons.close_rounded,
                        tooltip: 'Clear Reference Image',
                        color: Colors.redAccent,
                        onPressed: () => overlayNotifier.clearImage(),
                      ),
                      const SizedBox(width: 8),

                      // 3. Mirror Horizontally
                      FloatingIconButton(
                        icon: Icons.flip_outlined,
                        tooltip: 'Flip Horizontal',
                        active: overlayState.isFlippedHorizontal,
                        onPressed: () => overlayNotifier.toggleFlipHorizontal(),
                      ),
                      const SizedBox(width: 8),

                      // 4. Mirror Vertically
                      FloatingIconButton(
                        icon: Icons.transform_outlined,
                        tooltip: 'Flip Vertical',
                        active: overlayState.isFlippedVertical,
                        onPressed: () => overlayNotifier.toggleFlipVertical(),
                      ),
                      const SizedBox(width: 8),

                      // 8. Filters & Adjustments Toggler
                      FloatingIconButton(
                        icon: Icons.tune_rounded,
                        tooltip: 'Image Adjustments & Outlines',
                        active: overlayState.filterMode != OverlayFilterMode.normal ||
                            overlayState.fitMode != OverlayFitMode.contain,
                        onPressed: () => _showFiltersBottomSheet(context),
                      ),
                      const SizedBox(width: 8),

                      // 5. Lock Adjustments
                      FloatingIconButton(
                        icon: overlayState.isLocked
                            ? Icons.lock_rounded
                            : Icons.lock_open_rounded,
                        tooltip: overlayState.isLocked ? 'Unlock Overlay' : 'Lock Overlay',
                        active: overlayState.isLocked,
                        color: overlayState.isLocked ? Colors.orangeAccent : Colors.white,
                        onPressed: () => overlayNotifier.toggleLock(),
                      ),
                      const SizedBox(width: 8),

                      // 6. Reset Transformations
                      FloatingIconButton(
                        icon: Icons.restore_rounded,
                        tooltip: 'Reset Alignments',
                        onPressed: () => overlayNotifier.reset(),
                      ),
                      const SizedBox(width: 8),
                    ],

                    // Visual Divider for grid/help toggle
                    Container(
                      height: 28,
                      width: 1,
                      color: Colors.white12,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                    ),

                    // 7. Grid Toggle overlay
                    FloatingIconButton(
                      icon: overlayState.isGridVisible
                          ? Icons.grid_on_rounded
                          : Icons.grid_off_rounded,
                      tooltip: 'Toggle 3x3 Grid',
                      active: overlayState.isGridVisible,
                      onPressed: () => overlayNotifier.toggleGrid(),
                    ),
                    const SizedBox(width: 8),

                    // 8. Help/Instructions Button
                    FloatingIconButton(
                      icon: Icons.help_outline_rounded,
                      tooltip: 'App Instructions',
                      onPressed: () => _showInfoDialog(context, ref),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Displays the bottom sheet allowing users to pick from previously imported templates.
  void _showHistoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final reactiveState = ref.watch(overlayProvider);
            final overlayNotifier = ref.read(overlayProvider.notifier);
            final history = reactiveState.imageHistory;

            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 20,
                    right: 20,
                    bottom: 32,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E22).withValues(alpha: 0.85),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Chọn ảnh mẫu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white60),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Chọn từ các ảnh mẫu đã nhập gần đây',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Horizontal List of History Thumbnails
                      if (history.isNotEmpty)
                        SizedBox(
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              // Retrieve reversed history order (most recent first)
                              final path = history[history.length - 1 - index];
                              final filename = path.split('/').last;

                              return Container(
                                margin: const EdgeInsets.only(right: 14),
                                width: 100,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    // Thumbnail selection card
                                    GestureDetector(
                                      onTap: () {
                                        overlayNotifier.selectFromHistory(path);
                                        Navigator.pop(context);
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.black26,
                                              child: Image.file(
                                                File(path),
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) =>
                                                    const Center(
                                                  child: Icon(
                                                    Icons.broken_image_outlined,
                                                    color: Colors.white24,
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            filename,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white70,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Delete floating button on corner
                                    Positioned(
                                      top: -6,
                                      right: -6,
                                      child: GestureDetector(
                                        onTap: () {
                                          overlayNotifier.deleteFromHistory(path);
                                          // If list becomes empty, close sheet
                                          if (history.length <= 1) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(alpha: 0.8),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white12,
                                              width: 1,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.close_rounded,
                                            size: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      else
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                              'Chưa có hình ảnh nào được nhập.',
                              style: TextStyle(color: Colors.white30),
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),

                      // Import New Action Button
                      SizedBox(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final oldHistoryLength = history.length;
                            await overlayNotifier.pickImage();
                            // Pop bottom sheet ONLY if a new image was successfully selected
                            if (ref.read(overlayProvider).imagePath != null &&
                                ref.read(overlayProvider).imageHistory.length > oldHistoryLength) {
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(Icons.add_photo_alternate_outlined, size: 20),
                          label: const Text(
                            'Nhập ảnh mới từ thư viện',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Displays the filter adjustment panel bottom sheet.
  void _showFiltersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final overlayState = ref.watch(overlayProvider);
            final overlayNotifier = ref.read(overlayProvider.notifier);

            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 20,
                    right: 20,
                    bottom: 32,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E22).withValues(alpha: 0.85),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Căn chỉnh & Bộ lọc ảnh',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white60),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Fit Mode Section
                      const Text(
                        'Chế độ hiển thị ảnh mẫu',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildOptionButton(
                              context,
                              title: 'Vừa màn hình (Fit)',
                              icon: Icons.fit_screen_outlined,
                              isSelected: overlayState.fitMode == OverlayFitMode.contain,
                              onTap: () {
                                overlayNotifier.setFitMode(OverlayFitMode.contain);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildOptionButton(
                              context,
                              title: 'Tràn màn hình (Fill)',
                              icon: Icons.fullscreen_rounded,
                              isSelected: overlayState.fitMode == OverlayFitMode.cover,
                              onTap: () {
                                overlayNotifier.setFitMode(OverlayFitMode.cover);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Filter Mode Section
                      const Text(
                        'Bộ lọc trích xuất đường nét (Cho nền sáng/tối)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _buildFilterCard(
                              context,
                              title: 'Ảnh gốc',
                              icon: Icons.photo_outlined,
                              isSelected: overlayState.filterMode == OverlayFilterMode.normal,
                              onTap: () {
                                overlayNotifier.setFilterMode(OverlayFilterMode.normal);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Nét trắng (Nền tối)',
                              icon: Icons.grain_rounded,
                              isSelected: overlayState.filterMode == OverlayFilterMode.outlineWhite,
                              onTap: () async {
                                Navigator.pop(context); // Pop since outline starts processing isolate
                                await overlayNotifier.setFilterMode(OverlayFilterMode.outlineWhite);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Nét đen (Giấy sáng)',
                              icon: Icons.blur_linear_rounded,
                              isSelected: overlayState.filterMode == OverlayFilterMode.outlineBlack,
                              onTap: () async {
                                Navigator.pop(context); // Pop since outline starts processing isolate
                                await overlayNotifier.setFilterMode(OverlayFilterMode.outlineBlack);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Nét đỏ (Nổi bật)',
                              icon: Icons.adjust_rounded,
                              isSelected: overlayState.filterMode == OverlayFilterMode.outlineRed,
                              onTap: () async {
                                Navigator.pop(context); // Pop since outline starts processing isolate
                                await overlayNotifier.setFilterMode(OverlayFilterMode.outlineRed);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Trắng đen',
                              icon: Icons.filter_b_and_w_outlined,
                              isSelected: overlayState.filterMode == OverlayFilterMode.grayscale,
                              onTap: () {
                                overlayNotifier.setFilterMode(OverlayFilterMode.grayscale);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Tương phản',
                              icon: Icons.contrast_rounded,
                              isSelected: overlayState.filterMode == OverlayFilterMode.highContrast,
                              onTap: () {
                                overlayNotifier.setFilterMode(OverlayFilterMode.highContrast);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Đảo màu',
                              icon: Icons.difference_outlined,
                              isSelected: overlayState.filterMode == OverlayFilterMode.invert,
                              onTap: () {
                                overlayNotifier.setFilterMode(OverlayFilterMode.invert);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Phủ xanh Cyan',
                              icon: Icons.lens_blur_rounded,
                              isSelected: overlayState.filterMode == OverlayFilterMode.tintCyan,
                              onTap: () {
                                overlayNotifier.setFilterMode(OverlayFilterMode.tintCyan);
                              },
                            ),
                            _buildFilterCard(
                              context,
                              title: 'Phủ vàng ấm',
                              icon: Icons.wb_sunny_rounded,
                              isSelected: overlayState.filterMode == OverlayFilterMode.tintAmber,
                              onTap: () {
                                overlayNotifier.setFilterMode(OverlayFilterMode.tintAmber);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOptionButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? theme.colorScheme.primary : Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? theme.colorScheme.primary : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 100,
      child: Card(
        color: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.03),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isSelected
                ? theme.colorScheme.primary
                : Colors.white.withValues(alpha: 0.06),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? theme.colorScheme.primary : Colors.white60,
                  size: 22,
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected ? theme.colorScheme.primary : Colors.white70,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
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
