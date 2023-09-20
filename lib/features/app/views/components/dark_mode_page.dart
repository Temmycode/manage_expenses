import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/theme/dark_mode_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/dark_mode_enum.dart';

import '../../utils/text/title_text.dart';

class DarkModePage extends ConsumerWidget {
  const DarkModePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : CupertinoColors.white,
        centerTitle: false,
        elevation: 0,
        title: const TitleText(
          text: "Categories",
          size: 24,
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const TitleText(
              text: "Off",
              weight: FontWeight.normal,
              size: 16,
            ),
            trailing: Radio(
              value: DarkMode.light,
              groupValue: ref.watch(darkModeProvider),
              onChanged: (value) =>
                  ref.read(darkModeProvider.notifier).state = value!,
            ),
          ),
          ListTile(
            title: const TitleText(
              text: "On",
              weight: FontWeight.normal,
              size: 16,
            ),
            trailing: Radio(
              value: DarkMode.dark,
              groupValue: ref.watch(darkModeProvider),
              onChanged: (value) =>
                  ref.read(darkModeProvider.notifier).state = value!,
            ),
          ),
          ListTile(
            title: const TitleText(
              text: "Use device settings",
              weight: FontWeight.normal,
              size: 16,
            ),
            trailing: Radio(
              value: DarkMode.system,
              groupValue: ref.watch(darkModeProvider),
              onChanged: (value) =>
                  ref.read(darkModeProvider.notifier).state = value!,
            ),
          )
        ],
      ),
    );
  }
}
