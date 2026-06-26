import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/services/storage_service.dart';

void main() async {
  // Step 1: Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Step 2: Initialize Shared Preferences for state persistence
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Provide the shared preferences instance synchronously
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
  );
}
