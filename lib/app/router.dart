import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/camera/presentation/home_screen.dart';
import '../features/camera/presentation/permission_page.dart';
import '../features/camera/presentation/permission_provider.dart';

/// Provider for app router setup.
/// Handles initial routing, transitions, and permission gates.
final routerProvider = Provider<GoRouter>((ref) {
  final permissionState = ref.watch(permissionProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isChecking = permissionState.status == PermissionStatusEnum.checking;
      final isGranted = permissionState.status == PermissionStatusEnum.granted;
      
      // If we are checking permissions, show the initial loader page
      if (isChecking) {
        return '/';
      }
      
      final goingToPermission = state.matchedLocation == '/permission';
      
      if (!isGranted && !goingToPermission) {
        return '/permission';
      }
      if (isGranted && (goingToPermission || state.matchedLocation == '/')) {
        return '/home';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      GoRoute(
        path: '/permission',
        builder: (context, state) => const PermissionPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
