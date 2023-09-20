import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';
import '../../providers/theme/dark_mode_provider.dart';
import '../../utils/enums/dark_mode_enum.dart';

class TabContainer extends ConsumerWidget {
  final bool active;
  final String name;
  const TabContainer({
    super.key,
    required this.active,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border:
            active ? Border.all(color: Colors.grey.shade400, width: 1) : null,
      ),
      child: SmallText(
        text: name,
        color: isDarkMode ? Colors.white : Colors.black,
        weight: FontWeight.w600,
      ),
    );
  }
}
