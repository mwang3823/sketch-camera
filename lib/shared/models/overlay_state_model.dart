import 'package:equatable/equatable.dart';

/// Formatting and scaling modes for the trace image overlay.
enum OverlayFitMode { contain, cover }

/// Color processing filters available for drawing outlines.
enum OverlayFilterMode {
  normal,
  outlineWhite,
  outlineBlack,
  outlineRed,
  grayscale,
  invert,
  highContrast,
  tintCyan,
  tintAmber,
}

/// Immutable model representing the state of the trace overlay image.
/// Extends [Equatable] for performant state updates and checks.
class OverlayStateModel extends Equatable {
  final String? imagePath;
  final double opacity;
  final double scale;
  final double rotation; // in radians
  final double translationX;
  final double translationY;
  final bool isFlippedHorizontal;
  final bool isFlippedVertical;
  final bool isLocked;
  final bool isGridVisible;
  final List<String> imageHistory;
  final OverlayFitMode fitMode;
  final OverlayFilterMode filterMode;
  final String? processedImagePath;
  final bool isProcessing;

  const OverlayStateModel({
    this.imagePath,
    this.opacity = 0.5,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.translationX = 0.0,
    this.translationY = 0.0,
    this.isFlippedHorizontal = false,
    this.isFlippedVertical = false,
    this.isLocked = false,
    this.isGridVisible = false,
    this.imageHistory = const [],
    this.fitMode = OverlayFitMode.contain,
    this.filterMode = OverlayFilterMode.normal,
    this.processedImagePath,
    this.isProcessing = false,
  });

  /// Creates a copy of this state with updated fields.
  OverlayStateModel copyWith({
    String? imagePath,
    double? opacity,
    double? scale,
    double? rotation,
    double? translationX,
    double? translationY,
    bool? isFlippedHorizontal,
    bool? isFlippedVertical,
    bool? isLocked,
    bool? isGridVisible,
    List<String>? imageHistory,
    OverlayFitMode? fitMode,
    OverlayFilterMode? filterMode,
    String? processedImagePath,
    bool? isProcessing,
    bool clearImage = false,
    bool clearProcessedImage = false,
  }) {
    return OverlayStateModel(
      imagePath: clearImage ? null : (imagePath ?? this.imagePath),
      opacity: opacity ?? this.opacity,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      translationX: translationX ?? this.translationX,
      translationY: translationY ?? this.translationY,
      isFlippedHorizontal: isFlippedHorizontal ?? this.isFlippedHorizontal,
      isFlippedVertical: isFlippedVertical ?? this.isFlippedVertical,
      isLocked: isLocked ?? this.isLocked,
      isGridVisible: isGridVisible ?? this.isGridVisible,
      imageHistory: imageHistory ?? this.imageHistory,
      fitMode: fitMode ?? this.fitMode,
      filterMode: filterMode ?? this.filterMode,
      processedImagePath: clearProcessedImage ? null : (processedImagePath ?? this.processedImagePath),
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  @override
  List<Object?> get props => [
        imagePath,
        opacity,
        scale,
        rotation,
        translationX,
        translationY,
        isFlippedHorizontal,
        isFlippedVertical,
        isLocked,
        isGridVisible,
        imageHistory,
        fitMode,
        filterMode,
        processedImagePath,
        isProcessing,
      ];
}
