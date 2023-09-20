import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/theme/dark_mode_provider.dart';
import '../enums/dark_mode_enum.dart';

class TitleText extends ConsumerWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  const TitleText({
    super.key,
    required this.text,
    this.size = 20,
    this.color = Colors.black,
    this.weight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (isDarkMode) {
      return Text(
        text,
        style: TextStyle(
          fontSize: size == 20 ? 20 : size,
          fontWeight: weight == FontWeight.bold ? FontWeight.bold : weight,
          color: color == Colors.black ? Colors.white : color,
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
          fontSize: size == 20 ? 20 : size,
          fontWeight: weight == FontWeight.bold ? FontWeight.bold : weight,
          color: color == Colors.black ? Colors.black : color,
        ),
      );
    }
  }
}
