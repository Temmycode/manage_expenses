import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/navigator_provider.dart';
import 'package:manage_expenses/features/app/providers/system_brightness_provider.dart';
import 'package:manage_expenses/features/app/utils/constants/navigator_pages.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final brightness = ref.watch(systemBrightnessProvider(context));
    if (brightness == Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      );
    }
    final currentIndex = ref.watch(navigatorProvider);
    return Scaffold(
      body: navigatorPages[currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: (value) => ref.read(navigatorProvider.notifier).state = value,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0
                  ? CupertinoIcons.tray_arrow_up_fill
                  : CupertinoIcons.tray_arrow_up,
            ),
            label: "Expenses",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 1
                  ? CupertinoIcons.chart_bar_fill
                  : CupertinoIcons.chart_bar,
            ),
            label: "Reports",
          ),
          const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add), label: "Add"),
          BottomNavigationBarItem(
            icon: Icon(
                currentIndex == 3 ? Icons.settings : Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
