import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/expense_of_provider.dart';
import 'package:manage_expenses/features/app/providers/theme/dark_mode_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/dark_mode_enum.dart';
import 'package:manage_expenses/features/app/utils/enums/expense_of_enum.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';
import 'package:manage_expenses/features/app/views/all_expense_page/components/day_expens.dart';
import 'package:manage_expenses/features/app/views/all_expense_page/components/months_expense.dart';
import 'package:manage_expenses/features/app/views/all_expense_page/components/week_expense.dart';
import 'package:manage_expenses/features/app/views/components/drop_down_menu_item.dart';

import '../../../data/providers/logic/todays_expenses_provider.dart';

class AllExpensePage extends ConsumerWidget {
  const AllExpensePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Colors.black : CupertinoColors.systemGroupedBackground,
      body: isDarkMode
          // when it is dark mode
          ? CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: false,
                  elevation: 0,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    // titlePadding: EdgeInsets.zero,
                    background: Container(color: Colors.grey.shade900),
                  ),
                  expandedHeight: 120,
                  toolbarHeight: 120,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: "Expenses",
                        size: 40,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const CupertinoSearchTextField(
                        placeholder: "Search Expense",
                        style: TextStyle(color: Colors.white),
                        // style: ,
                      )
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmallText(text: "Spent this:"),
                            SizedBox(
                              width: 10,
                            ),
                            DropDownMenuButton()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SmallText(
                              text: "\$",
                              size: 20,
                              weight: FontWeight.bold,
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final filter = ref.watch(expenseOfProvider);
                                final todaysExpense = ref.watch(
                                  todaysExpensesProvider,
                                );
                                switch (filter) {
                                  case ExpenseOf.day:
                                    return todaysExpense.when(
                                      data: (price) {
                                        return TitleText(
                                          text: price.toStringAsFixed(2),
                                          size: 40,
                                        );
                                      },
                                      error: (error, stk) => Container(),
                                      loading: () => const TitleText(
                                        text: "0.00",
                                        size: 40,
                                      ),
                                    );
                                  case ExpenseOf.week:
                                    return const SizedBox(
                                      child: Text("week"),
                                    );
                                  case ExpenseOf.month:
                                    return const SizedBox(
                                      child: Text("month"),
                                    );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final filter = ref.watch(expenseOfProvider);
                    switch (filter) {
                      case ExpenseOf.day:
                        return const DayExpense();
                      case ExpenseOf.week:
                        return const WeekExpense();
                      case ExpenseOf.month:
                        return const MonthExpenses();
                    }
                  },
                ),
              ],
            )
          // when it is light mode
          : SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    elevation: 0,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      // titlePadding: EdgeInsets.zero,
                      background: Container(
                          color: CupertinoColors.secondarySystemBackground),
                    ),
                    expandedHeight: 120,
                    toolbarHeight: 120,
                    title: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          text: "Expenses",
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CupertinoSearchTextField(
                          placeholder: "Search Expense",
                          style: TextStyle(color: Colors.white),
                          // style: ,
                        )
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallText(text: "Spent this:"),
                              SizedBox(
                                width: 10,
                              ),
                              DropDownMenuButton()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SmallText(
                                text: "\$",
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final filter = ref.watch(expenseOfProvider);
                                  final todaysExpense = ref.watch(
                                    todaysExpensesProvider,
                                  );
                                  switch (filter) {
                                    case ExpenseOf.day:
                                      return todaysExpense.when(
                                        data: (price) {
                                          return TitleText(
                                            text: price.toStringAsFixed(2),
                                            size: 40,
                                          );
                                        },
                                        error: (error, stk) => Container(),
                                        loading: () => const TitleText(
                                          text: "0.00",
                                          size: 40,
                                        ),
                                      );
                                    case ExpenseOf.week:
                                      return const SizedBox(
                                        child: Text("week"),
                                      );
                                    case ExpenseOf.month:
                                      return const SizedBox(
                                        child: Text("month"),
                                      );
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final filter = ref.watch(expenseOfProvider);

                      switch (filter) {
                        case ExpenseOf.day:
                          return const DayExpense();
                        case ExpenseOf.week:
                          return const WeekExpense();
                        case ExpenseOf.month:
                          return const MonthExpenses();
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
