import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/theme/dark_mode_provider.dart';
import '../enums/dark_mode_enum.dart';

class SmallText extends ConsumerWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  // final TextOverflow? overfolw;
  const SmallText({
    super.key,
    required this.text,
    this.size = 16,
    this.color = Colors.grey,
    this.weight = FontWeight.normal,
    // this.overfolw = TextOverflow.ellipsis,
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
          fontSize: size == 16 ? 16 : size,
          fontWeight: weight == FontWeight.normal ? FontWeight.normal : weight,
          color: color == Colors.grey ? Colors.grey : color,
          // overflow: overfolw == TextOverflow.ellipsis
          //     ? TextOverflow.ellipsis
          //     : overfolw,
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
          fontSize: size == 16 ? 16 : size,
          fontWeight: weight == FontWeight.normal ? FontWeight.normal : weight,
          color: color == Colors.grey ? Colors.grey : color,
          // overflow: overfolw == TextOverflow.ellipsis
          //     ? TextOverflow.ellipsis
          //     : overfolw,
        ),
      );
    }
  }
}
