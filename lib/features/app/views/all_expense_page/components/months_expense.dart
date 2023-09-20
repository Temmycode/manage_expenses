import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/system_brightness_provider.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';
import 'package:manage_expenses/features/data/providers/all_expenses/all_months_expense_provider.dart';
import 'package:manage_expenses/features/data/providers/get_all_category_provider.dart';
import '../../components/expense_list_tile.dart';

class MonthExpenses extends ConsumerWidget {
  const MonthExpenses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(systemBrightnessProvider(context));
    final monthsExpenses = ref.watch(allThisMonthsExpenseProvider);
    final categories = ref.watch(getAllCateogryProvider);
    return monthsExpenses.when(
      data: (expenses) {
        if (expenses.isEmpty) {
          // TODO: WORK ON AN ANIMATION FOR THIS SECTION
          return const SliverToBoxAdapter(
            child: Center(
              child: TitleText(
                text: "No Expenses yet",
                size: 18,
                weight: FontWeight.normal,
              ),
            ),
          );
        } else {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                String color = '';
                return categories.when(
                  data: (category) {
                    for (var categ in category) {
                      if (categ.categoryName == expenses[index].category) {
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
                  error: (error, stk) => SliverToBoxAdapter(child: Container()),
                  loading: () => SliverToBoxAdapter(child: Container()),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: brightness == Brightness.dark
                      ? Colors.white24
                      : Colors.grey,
                );
              },
            ),
          );
        }
      },
      error: (e, stk) => const SliverToBoxAdapter(child: SizedBox()),
      loading: () => SliverToBoxAdapter(child: Container()),
    );
  }
}
