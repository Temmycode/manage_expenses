import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/theme/brightness_provider.dart';
import 'package:manage_expenses/features/app/providers/theme/dark_mode_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/dark_mode_enum.dart';
import 'package:manage_expenses/features/app/views/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(brightnessProvider);
    final darkMode = ref.watch(darkModeProvider);
    return MaterialApp(
      title: 'Mangage Expenses',
      darkTheme: darkMode == DarkMode.dark
          ? ThemeData.dark()
          : darkMode == DarkMode.light
              ? ThemeData.dark()
              : ThemeData.dark(),
      themeMode: brightness,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.grey,
        useMaterial3: false,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          return const HomePage();
        },
      ),
    );
  }
}
