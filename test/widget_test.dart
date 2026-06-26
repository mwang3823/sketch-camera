import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch_camera/app/app.dart';
import 'package:sketch_camera/core/services/storage_service.dart';

void main() {
  testWidgets('App initialization and permission gate smoke test', (WidgetTester tester) async {
    // Initialize mock SharedPreferences values before constructing the app
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const App(),
      ),
    );

    // Verify if our loading view or initial screen exists
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
