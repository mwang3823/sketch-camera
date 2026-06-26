# Camera Trace - Complete Product Requirement Document (PRD)

> **Role**
>
> You are a Senior Flutter Engineer, UI/UX Designer, Software Architect, and QA Engineer with 15+ years of experience.
>
> Your task is to build a **production-ready Flutter application** from scratch.
>
> Do NOT generate demo code or pseudo code.
>
> Every file must be complete, compilable, and production quality.
>
> If the response exceeds the context limit, continue automatically from the last generated file until the project is 100% complete.

---

# 1. Project Information

## Project Name

Camera Trace

## Description

This application allows artists to trace objects in the real world.

Workflow:

1. User opens the app.
2. Camera opens immediately.
3. User imports an image from the gallery.
4. Image appears above the camera preview.
5. User adjusts transparency.
6. User moves/scales/rotates the image until it matches the real object.
7. User locks the image.
8. User starts drawing on paper while looking through the phone.

The app itself **does not perform drawing**.

It only helps users align an image with the camera.

---

# 2. Development Rules

## Flutter Version

Use latest stable Flutter.

Never use deprecated APIs.

## Language

Dart 3

Null Safety

---

## State Management

Use Riverpod only.

No GetX.

No Provider.

No Bloc.

---

## Navigation

Use go_router.

---

## Dependency Injection

Simple Riverpod Providers.

No get_it.

---

## Architecture

Use Clean Architecture.

```text
lib/
│
├── app/
│      app.dart
│      router.dart
│      theme.dart
│
├── core/
│      constants/
│      extensions/
│      services/
│      utils/
│
├── features/
│
│      camera/
│            data/
│            domain/
│            presentation/
│
│      overlay/
│            data/
│            domain/
│            presentation/
│
│      settings/
│
├── shared/
│      widgets/
│      models/
│
└── main.dart
```

Every feature must be isolated.

---

# 3. Packages

Use latest versions.

Required:

camera

image_picker

permission_handler

flutter_riverpod

shared_preferences

path_provider

go_router

equatable

Optional:

photo_view

flutter_animate

flex_color_scheme

---

# 4. App Startup

When app starts:

Step 1

Initialize Flutter bindings.

Step 2

Load saved settings.

Step 3

Request permissions.

Camera

Storage / Photos

Step 4

Initialize camera.

Step 5

Navigate to Home Screen.

If permission denied:

Display friendly page explaining why.

Provide button:

"Grant Permission"

---

# 5. Home Screen

This is the main screen.

Structure:

```text
Scaffold

Stack

├── CameraPreview

├── Grid Overlay

├── Overlay Image

├── Gesture Layer

├── Top Toolbar

├── Bottom Toolbar

└── Opacity Slider
```

---

# 6. Camera

Requirements:

Support:

Rear camera

Front camera

Switch camera

High Resolution

Landscape

Portrait

Handle:

Camera unavailable

Initialization error

Permission denied

Dispose correctly

Never leak resources.

---

# 7. Import Image

Button:

Gallery

When clicked:

Open gallery.

User selects image.

Supported:

PNG

JPEG

WEBP

Store image path.

Load image.

Display immediately.

If cancelled:

Do nothing.

---

# 8. Overlay Image

The overlay image is displayed above CameraPreview.

Requirements:

Opacity

Scale

Rotation

Translation

Mirror Horizontal

Mirror Vertical

Center on first load.

Remember last state.

---

# 9. Image Gestures

Use GestureDetector.

Single finger:

Move image.

Two fingers:

Zoom.

Rotate.

Double tap:

Reset transform.

Long press:

Toggle Lock.

When locked:

Disable all gestures.

Display small lock badge.

---

# 10. Opacity

Bottom slider.

Range

0.0

↓

1.0

Realtime.

Show current percentage.

Example:

Opacity

65%

---

# 11. Grid

Toggle button.

Show 3x3 camera grid.

Grid color:

White

30% opacity

Ignore pointer.

---

# 12. Toolbar

Top Toolbar

Contains:

Back

Title

Settings

Bottom Toolbar

Contains:

Gallery

Camera Switch

Flip H

Flip V

Lock

Reset

Grid

Buttons:

Rounded

Ripple animation

Material 3

---

# 13. Reset

Reset only overlay.

Restore:

Position

Rotation

Scale

Opacity

Flip

Do NOT restart camera.

---

# 14. Flip

Flip Horizontal.

Flip Vertical.

Should animate smoothly.

---

# 15. Save State

Whenever user changes:

Opacity

Scale

Rotation

Position

Flip

Save automatically.

Use SharedPreferences.

Restore next launch.

---

# 16. Theme

Material 3.

Dark Theme.

Primary color:

Blue

Background:

Near Black

Cards:

Dark Gray

Rounded:

16 px

Use typography scale.

---

# 17. Animations

Every interaction should animate.

Examples:

Toolbar appears.

Buttons press.

Dialogs.

Opacity.

Reset.

Flip.

Page transition.

Use flutter_animate.

Duration:

200~300ms.

---

# 18. Error Handling

Never crash.

Handle:

Image loading failed.

Camera failed.

Permission denied.

Memory issues.

Unexpected exceptions.

Show:

SnackBar

Retry button.

Logs in debug mode.

---

# 19. Performance

Target:

60 FPS.

Avoid rebuilds.

Separate providers.

Use:

const widgets

RepaintBoundary

Memoization

Dispose controllers.

No memory leaks.

---

# 20. Accessibility

Minimum button size:

48dp.

Readable fonts.

Semantic labels.

Support screen readers.

---

# 21. Folder Responsibilities

camera/

Only camera logic.

overlay/

Only overlay state.

settings/

Only settings.

shared/

Reusable widgets.

core/

Utilities.

No feature should access another feature directly.

---

# 22. UI Style

Modern.

Minimal.

Professional.

Inspired by:

* Adobe Lightroom
* Procreate
* Figma
* iOS Camera

Use floating controls.

Blurred toolbar.

Rounded buttons.

Soft shadows.

Elegant spacing.

No clutter.

---

# 23. Widgets

Create reusable widgets:

CameraPreviewWidget

OverlayImageWidget

OpacitySliderWidget

GridPainter

BottomToolbar

TopToolbar

FloatingIconButton

PermissionPage

ErrorView

LoadingView

Each widget in its own file.

---

# 24. Provider Structure

CameraProvider

OverlayProvider

SettingsProvider

PermissionProvider

ImagePickerProvider

Separate state cleanly.

---

# 25. File Naming

snake_case only.

Example:

camera_page.dart

overlay_state.dart

opacity_slider.dart

Never use generic names like:

utils2.dart

helper.dart

newfile.dart

---

# 26. Documentation

Every class:

DartDoc.

Every public method:

DartDoc.

Complex logic:

Explain with comments.

---

# 27. README.md

Generate:

Project overview

Architecture

Folder structure

Packages

Setup

Run

Permissions

Future roadmap

Screenshots placeholder

---

# 28. AI Generation Strategy

Generate files in this exact order:

1. pubspec.yaml
2. Folder tree
3. main.dart
4. app.dart
5. router.dart
6. theme.dart
7. constants
8. models
9. services
10. providers
11. widgets
12. screens
13. README

After each file:

Verify imports.

Verify compilation.

Do not skip any dependency.

Do not leave TODOs.

Do not leave placeholders.

Do not omit code.

---

# 29. Acceptance Criteria

The project is complete only if:

* `flutter pub get` succeeds.
* `flutter analyze` reports no errors.
* The app runs on Android and iOS.
* Camera preview works.
* Image import works.
* Overlay renders correctly.
* Gestures (move, scale, rotate) work.
* Opacity updates in real time.
* Flip horizontal/vertical works.
* Lock mode disables gestures.
* Grid overlay toggles correctly.
* State is restored after restarting the app.
* The codebase follows Clean Architecture and Riverpod best practices.
* There are no placeholder implementations, missing files, or incomplete features.

If the generated output reaches the token limit, continue automatically in the next response from the exact point where generation stopped until every file in the project has been completed.
