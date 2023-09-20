import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:manage_expenses/features/app/extensions/capitalize_extenstion.dart';
import 'package:manage_expenses/features/app/providers/report_page_enum_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/report_page_section_enum.dart';
import 'package:manage_expenses/features/app/views/components/tab_container.dart';
import 'package:manage_expenses/features/data/providers/get_all_category_provider.dart';
import 'package:manage_expenses/features/data/providers/report_screen_providers/month_report_expense.dart';
import 'package:manage_expenses/features/data/providers/report_screen_providers/week_report_expense_provider.dart';
import '../../providers/theme/dark_mode_provider.dart';
import '../../utils/enums/dark_mode_enum.dart';
import '../../utils/text/small_text.dart';
import '../../utils/text/title_text.dart';
import 'expense_list_tile.dart';

class ReportPageModel extends ConsumerWidget {
  final DateTime? weekStart;
  final DateTime? weekEnd;
  final DateTime? monthStart;
  final DateTime? monthEnd;
  const ReportPageModel({
    super.key,
    this.weekEnd,
    this.weekStart,
    this.monthStart,
    this.monthEnd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(reportPageEnumProvider);
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    if (section == ReportPageSections.week) {
      // fomatted week
      final formattedWeekEnd = DateFormat('d MMM').format(weekEnd!);
      final formattedWeekStart = DateFormat('d MMM').format(weekStart!);

      return Scaffold(
        backgroundColor:
            isDarkMode ? Colors.black : CupertinoColors.systemGroupedBackground,
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.more_horiz),
                  ),
                ),
                const SizedBox(height: 20),
                // THE WEEK INFO:
                if (section == ReportPageSections.week)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TitleText(
                        text: '$formattedWeekStart - $formattedWeekEnd',
                        weight: FontWeight.w500,
                        size: 14,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                // TOTAL EXPENSE PRICE:
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SmallText(
                      text: "\$",
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    TitleText(
                      text: "250.99",
                      size: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    SmallText(
                      text: "Total spent this week",
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // TODO: THE BARCHART SHOULD BE HERE:

                // THE TABS TO CHANGE THE RESULT ON THE SCREEN:
                Row(
                  children: ReportPageSections.values
                      .map(
                        (value) => GestureDetector(
                          onTap: () => ref
                              .read(reportPageEnumProvider.notifier)
                              .state = value,
                          child: TabContainer(
                            active: section == value,
                            name: value.capitalize(value.name),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),

                // THIE LIST OF THE EXPENSES:
                Consumer(
                  builder: (context, ref, child) {
                    // convert the date from start to end to a string for the provider:
                    final dateTime = '$weekStart  $weekEnd';
                    // week expense provider
                    final weekExpense = ref.watch(
                      reportWeekExpenseProvider(dateTime),
                    );
                    // category provider
                    final categories = ref.watch(getAllCateogryProvider);
                    // return what i need
                    return weekExpense.when(
                      data: (expenses) {
                        if (expenses.isEmpty) {
                          // TODO: WORK ON AN ANIMATION FOR THIS SECTION
                          return const Center(
                            child: TitleText(
                              text: "No Expenses yet",
                              size: 18,
                              weight: FontWeight.normal,
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Divider(
                                color:
                                    isDarkMode ? Colors.white38 : Colors.grey,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: expenses.length,
                                itemBuilder: (context, index) {
                                  String color = '#bcc0c4';
                                  return categories.when(
                                    data: (category) {
                                      for (var categ in category) {
                                        if (categ.categoryName ==
                                            expenses[index].category) {
                                          color = categ.color;
                                        }
                                      }
                                      return ExpenseListTile(
                                        category: expenses[index].category,
                                        name: expenses[index].title,
                                        date: expenses[index].date,
                                        price: expenses[index].price,
                                        categoryColor: color,
                                      );
                                    },
                                    error: (error, stk) => Container(),
                                    loading: () => Container(),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: isDarkMode
                                        ? Colors.white24
                                        : Colors.grey,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      },
                      error: (e, stk) => Container(),
                      loading: () => Container(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // formatted month
      final startMonth = DateFormat('d MMM').format(monthStart!);
      final endMonth = DateFormat('d MMM').format(monthEnd!);
      return Scaffold(
        backgroundColor:
            isDarkMode ? Colors.black : CupertinoColors.systemGroupedBackground,
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.more_horiz),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleText(
                      text: '$startMonth - $endMonth',
                      weight: FontWeight.w500,
                      size: 14,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                // TOTAL EXPENSE PRICE:
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SmallText(
                      text: "\$",
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    TitleText(
                      text: "250.99",
                      size: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    SmallText(
                      text: "Total spent this week",
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // TODO: THE BARCHART SHOULD BE HERE:

                // THE TABS TO CHANGE THE RESULT ON THE SCREEN:
                Row(
                  children: ReportPageSections.values
                      .map(
                        (value) => GestureDetector(
                          onTap: () => ref
                              .read(reportPageEnumProvider.notifier)
                              .state = value,
                          child: TabContainer(
                            active: section == value,
                            name: value.capitalize(value.name),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                // THIE LIST OF THE EXPENSES:
                Consumer(
                  builder: (context, ref, child) {
                    // convert the datetime from start to end for the provider:
                    final dateTime = '$monthStart  $monthEnd';
                    final monthExpense = ref.watch(
                      reportMonthExpenseProvider(dateTime),
                    );
                    // category provider
                    final categories = ref.watch(getAllCateogryProvider);
                    // return what i need
                    return monthExpense.when(
                      data: (expenses) {
                        if (expenses.isEmpty) {
                          // TODO: WORK ON AN ANIMATION FOR THIS SECTION
                          return const Center(
                            child: TitleText(
                              text: "No Expenses yet",
                              size: 18,
                              weight: FontWeight.normal,
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Divider(
                                color:
                                    isDarkMode ? Colors.white38 : Colors.grey,
                              ),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: expenses.length,
                                itemBuilder: (context, index) {
                                  String color = '#bcc0c4';
                                  return categories.when(
                                    data: (category) {
                                      for (var categ in category) {
                                        if (categ.categoryName ==
                                            expenses[index].category) {
                                          color = categ.color;
                                        }
                                      }
                                      return ExpenseListTile(
                                        category: expenses[index].category,
                                        name: expenses[index].title,
                                        date: expenses[index].date,
                                        price: expenses[index].price,
                                        categoryColor: color,
                                      );
                                    },
                                    error: (error, stk) => Container(),
                                    loading: () => Container(),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: isDarkMode
                                        ? Colors.white24
                                        : Colors.grey,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      },
                      error: (e, stk) => Container(),
                      loading: () => Container(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
