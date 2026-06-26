import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../shared/models/overlay_state_model.dart';
export '../../../shared/models/overlay_state_model.dart';
import '../../../core/services/storage_service.dart';

/// Notifier that manages the interactive overlay image configurations.
/// Synchronizes changes to local storage for instant state restoration on app reload.
class OverlayNotifier extends StateNotifier<OverlayStateModel> {
  final StorageService _storageService;

  OverlayNotifier(this._storageService) : super(const OverlayStateModel()) {
    _loadState();
  }

  /// Restores trace settings stored in SharedPreferences.
  void _loadState() {
    try {
      final savedData = _storageService.loadOverlayState();
      final savedHistory = _storageService.loadImageHistory();
      state = OverlayStateModel(
        imagePath: savedData['imagePath'] as String?,
        opacity: savedData['opacity'] as double,
        scale: savedData['scale'] as double,
        rotation: savedData['rotation'] as double,
        translationX: savedData['translationX'] as double,
        translationY: savedData['translationY'] as double,
        isFlippedHorizontal: savedData['flipH'] as bool,
        isFlippedVertical: savedData['flipV'] as bool,
        isGridVisible: savedData['gridVisible'] as bool,
        isLocked: false, // Default to unlocked on fresh app launch
        imageHistory: savedHistory,
      );
    } catch (_) {
      // Fallback to default state if parsing fails
    }
  }

  /// Automatically persists the current overlay configuration settings.
  Future<void> _saveState() async {
    try {
      await _storageService.saveOverlayState(
        imagePath: state.imagePath,
        opacity: state.opacity,
        scale: state.scale,
        rotation: state.rotation,
        translationX: state.translationX,
        translationY: state.translationY,
        flipH: state.isFlippedHorizontal,
        flipV: state.isFlippedVertical,
        gridVisible: state.isGridVisible,
      );
    } catch (_) {
      // Silent catch to prevent UI interruption on write failure
    }
  }

  /// Helper to add an image path to history, keeping it unique and capping at 15 items.
  void _addToHistory(String path) {
    final currentHistory = List<String>.from(state.imageHistory);
    currentHistory.remove(path); // push to most recent
    currentHistory.add(path);
    if (currentHistory.length > 15) {
      currentHistory.removeAt(0);
    }
    state = state.copyWith(imageHistory: currentHistory);
    _storageService.saveImageHistory(currentHistory);
  }


  /// Deletes an image from the saved history list.
  void deleteFromHistory(String path) {
    final currentHistory = List<String>.from(state.imageHistory);
    currentHistory.remove(path);
    state = state.copyWith(imageHistory: currentHistory);
    _storageService.saveImageHistory(currentHistory);
    
    // If deleted image was the currently selected overlay, clear it
    if (state.imagePath == path) {
      clearImage();
    }
  }

  /// Launches the gallery picker to select a local reference image.
  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        state = state.copyWith(imagePath: pickedFile.path);
        _addToHistory(pickedFile.path);
        await _saveState();
      }
    } catch (_) {
      // Handled at display layer via providers
    }
  }

  /// Sets the overlay transparency level (from 0.0 to 1.0).
  void setOpacity(double opacity) {
    state = state.copyWith(opacity: opacity.clamp(0.0, 1.0));
    _saveState();
  }

  /// Updates translation offsets, scale and rotation values. Prevents edits when locked.
  void updateTransform({
    double? scale,
    double? rotation,
    double? translationX,
    double? translationY,
  }) {
    if (state.isLocked) return;
    state = state.copyWith(
      scale: scale,
      rotation: rotation,
      translationX: translationX,
      translationY: translationY,
    );
    _saveState();
  }

  /// Toggles structural gestures lock.
  void toggleLock() {
    state = state.copyWith(isLocked: !state.isLocked);
  }

  /// Toggles visibility of the 3x3 rule-of-thirds grid.
  void toggleGrid() {
    state = state.copyWith(isGridVisible: !state.isGridVisible);
    _saveState();
  }

  /// Mirror the overlay image horizontally.
  void toggleFlipHorizontal() {
    if (state.isLocked) return;
    state = state.copyWith(isFlippedHorizontal: !state.isFlippedHorizontal);
    _saveState();
  }

  /// Mirror the overlay image vertically.
  void toggleFlipVertical() {
    if (state.isLocked) return;
    state = state.copyWith(isFlippedVertical: !state.isFlippedVertical);
    _saveState();
  }

  /// Sets the fitting mode for scaling the overlay image.
  void setFitMode(OverlayFitMode fitMode) {
    state = state.copyWith(fitMode: fitMode);
    _saveState();
  }

  /// Sets the active filter processing mode (Grayscale, Outline, Invert, etc).
  Future<void> setFilterMode(OverlayFilterMode filterMode) async {
    if (state.imagePath == null) return;
    
    state = state.copyWith(filterMode: filterMode);
    _saveState();

    final isOutline = filterMode == OverlayFilterMode.outlineWhite ||
        filterMode == OverlayFilterMode.outlineBlack ||
        filterMode == OverlayFilterMode.outlineRed;

    if (isOutline && state.processedImagePath == null) {
      await _processOutlineImage();
    }
  }

  /// Processes Sobel outline edge detection in a separate background Isolate.
  Future<void> _processOutlineImage() async {
    if (state.imagePath == null) return;
    
    state = state.copyWith(isProcessing: true);
    
    try {
      final tempDir = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String outputPath = '${tempDir.path}/outline_$timestamp.png';

      final Map<String, String> params = {
        'inputPath': state.imagePath!,
        'outputPath': outputPath,
      };

      // Offload the CPU-intensive Sobel calculation to a background thread
      final processedPath = await compute(_runSobelIsolate, params);
      
      state = state.copyWith(
        processedImagePath: processedPath,
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(isProcessing: false);
      debugPrint('Error generating outline stencil: $e');
    }
  }

  /// Resets position, scale, rotation, mirroring, and unlock. Keeps selected image.
  void reset() {
    state = state.copyWith(
      scale: 1.0,
      rotation: 0.0,
      translationX: 0.0,
      translationY: 0.0,
      isFlippedHorizontal: false,
      isFlippedVertical: false,
      isLocked: false,
    );
    _saveState();
  }

  /// Clears the active trace image.
  void clearImage() {
    state = state.copyWith(
      clearImage: true,
      clearProcessedImage: true,
      filterMode: OverlayFilterMode.normal,
    );
    _saveState();
  }

  /// Selects an image from the saved history list.
  void selectFromHistory(String path) {
    state = state.copyWith(
      imagePath: path,
      clearProcessedImage: true,
      filterMode: OverlayFilterMode.normal,
    );
    _addToHistory(path);
    _saveState();
  }
}

/// Processes Sobel edge detection in a separate background isolate.
Future<String> _runSobelIsolate(Map<String, String> params) async {
  final inputPath = params['inputPath']!;
  final outputPath = params['outputPath']!;
  
  final bytes = await File(inputPath).readAsBytes();
  final image = img.decodeImage(bytes);
  if (image == null) throw Exception("Failed to decode image");
  
  // 1. Grayscale the image
  final grayscaleImage = img.grayscale(image);
  
  // 2. Apply Sobel filter
  final sobelImage = img.sobel(grayscaleImage);
  
  // 3. Post-process to yield white outlines on a transparent background
  for (final frame in sobelImage.frames) {
    for (final pixel in frame) {
      final r = pixel.r;
      if (r > 30) {
        // High edge intensity -> Solid white line
        pixel.r = 255;
        pixel.g = 255;
        pixel.b = 255;
        pixel.a = 255;
      } else {
        // Flat area -> Fully transparent background
        pixel.r = 0;
        pixel.g = 0;
        pixel.b = 0;
        pixel.a = 0;
      }
    }
  }

  final pngBytes = img.encodePng(sobelImage);
  await File(outputPath).writeAsBytes(pngBytes);
  return outputPath;
}

/// Provider for overlay alignment and style states.
final overlayProvider = StateNotifierProvider<OverlayNotifier, OverlayStateModel>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return OverlayNotifier(storage);
});
