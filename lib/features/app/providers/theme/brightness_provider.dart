import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/theme/dark_mode_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/dark_mode_enum.dart';

final brightnessProvider = Provider<ThemeMode>((ref) {
  final darkMode = ref.watch(darkModeProvider);
  switch (darkMode) {
    case DarkMode.dark:
      return ThemeMode.dark;
    case DarkMode.light:
      return ThemeMode.light;
    case DarkMode.system:
      return ThemeMode.system;
  }
});
