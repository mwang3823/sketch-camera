import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider that exposes the initialized [SharedPreferences] instance.
/// Must be overridden in the root [ProviderScope] on startup.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences has not been initialized');
});

/// Service class to manage saving and loading app settings and overlay states.
class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // SharedPreferences Keys
  static const String _keyImagePath = 'overlay_image_path';
  static const String _keyOpacity = 'overlay_opacity';
  static const String _keyScale = 'overlay_scale';
  static const String _keyRotation = 'overlay_rotation';
  static const String _keyTranslationX = 'overlay_translation_x';
  static const String _keyTranslationY = 'overlay_translation_y';
  static const String _keyFlipH = 'overlay_flip_h';
  static const String _keyFlipV = 'overlay_flip_v';
  static const String _keyGridVisible = 'overlay_grid_visible';
  static const String _keyImageHistory = 'overlay_image_history';

  /// Save overlay state parameters to SharedPreferences.
  Future<void> saveOverlayState({
    required String? imagePath,
    required double opacity,
    required double scale,
    required double rotation,
    required double translationX,
    required double translationY,
    required bool flipH,
    required bool flipV,
    required bool gridVisible,
  }) async {
    if (imagePath != null) {
      await _prefs.setString(_keyImagePath, imagePath);
    } else {
      await _prefs.remove(_keyImagePath);
    }
    await _prefs.setDouble(_keyOpacity, opacity);
    await _prefs.setDouble(_keyScale, scale);
    await _prefs.setDouble(_keyRotation, rotation);
    await _prefs.setDouble(_keyTranslationX, translationX);
    await _prefs.setDouble(_keyTranslationY, translationY);
    await _prefs.setBool(_keyFlipH, flipH);
    await _prefs.setBool(_keyFlipV, flipV);
    await _prefs.setBool(_keyGridVisible, gridVisible);
  }

  /// Load saved overlay state parameters.
  Map<String, dynamic> loadOverlayState() {
    return {
      'imagePath': _prefs.getString(_keyImagePath),
      'opacity': _prefs.getDouble(_keyOpacity) ?? 0.5,
      'scale': _prefs.getDouble(_keyScale) ?? 1.0,
      'rotation': _prefs.getDouble(_keyRotation) ?? 0.0,
      'translationX': _prefs.getDouble(_keyTranslationX) ?? 0.0,
      'translationY': _prefs.getDouble(_keyTranslationY) ?? 0.0,
      'flipH': _prefs.getBool(_keyFlipH) ?? false,
      'flipV': _prefs.getBool(_keyFlipV) ?? false,
      'gridVisible': _prefs.getBool(_keyGridVisible) ?? false,
    };
  }

  /// Save the list of imported image paths.
  Future<void> saveImageHistory(List<String> paths) async {
    await _prefs.setStringList(_keyImageHistory, paths);
  }

  /// Load the list of imported image paths.
  List<String> loadImageHistory() {
    return _prefs.getStringList(_keyImageHistory) ?? const [];
  }

  /// Clear all stored overlay states.
  Future<void> clearOverlayState() async {
    await _prefs.remove(_keyImagePath);
    await _prefs.remove(_keyOpacity);
    await _prefs.remove(_keyScale);
    await _prefs.remove(_keyRotation);
    await _prefs.remove(_keyTranslationX);
    await _prefs.remove(_keyTranslationY);
    await _prefs.remove(_keyFlipH);
    await _prefs.remove(_keyFlipV);
    await _prefs.remove(_keyGridVisible);
    await _prefs.remove(_keyImageHistory);
  }
}

/// Provider for the [StorageService].
final storageServiceProvider = Provider<StorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return StorageService(prefs);
});
