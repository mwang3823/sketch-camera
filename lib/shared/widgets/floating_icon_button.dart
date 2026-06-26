import 'dart:ui';
import 'package:flutter/material.dart';

/// Reusable glassmorphic button matching accessibility minimum constraints (48dp).
/// Offers ripple feedback animations, custom toggles, tooltips, and semantics.
class FloatingIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? color;
  final bool active;

  const FloatingIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = Colors.white;

    return Semantics(
      label: tooltip,
      button: true,
      enabled: true,
      child: Tooltip(
        message: tooltip ?? '',
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Material(
              color: active
                  ? activeColor.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.45),
              child: InkWell(
                onTap: onPressed,
                splashColor: activeColor.withValues(alpha: 0.4),
                highlightColor: activeColor.withValues(alpha: 0.2),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(
                      icon,
                      color: active ? activeColor : (color ?? inactiveColor),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
