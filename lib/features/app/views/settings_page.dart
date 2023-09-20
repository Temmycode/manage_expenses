import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/helpers/alert_dialog_helper.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';
import 'package:manage_expenses/features/app/views/components/dark_mode_page.dart';
import 'package:manage_expenses/features/data/providers/expense_notifier_provider.dart';
import '../providers/theme/dark_mode_provider.dart';
import '../utils/enums/dark_mode_enum.dart';
import 'category_page.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Colors.black : CupertinoColors.systemGroupedBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: TitleText(
                  text: "Settings",
                  size: 24,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.none,
                children: [
                  // CATEGORIES:
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategoryPage(),
                      ),
                    ),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Categories",
                          weight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: const CupertinoListTileChevron(),
                      ),
                    ),
                  ),

                  // LIGHT MODE DARK MODE:
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DarkModePage(),
                      ),
                    ),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Dark Mode",
                          weight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: const CupertinoListTileChevron(),
                      ),
                    ),
                  ),

                  // EARSE DATA:
                  GestureDetector(
                    onTap: () {
                      alertDialogHelper(
                          context,
                          "Are you sure you want to remove all your data?",
                          "Clear Data", ok: () {
                        ref
                            .read(expenseNotifierProvider.notifier)
                            .clearDatabase();
                        Navigator.pop(context);
                      });
                    },
                    child: DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: const SmallText(
                          text: "Erase Data",
                          weight: FontWeight.w600,
                          color: Colors.red,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Container(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
