import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/system_brightness_provider.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';
import 'package:manage_expenses/features/data/providers/all_expenses/all_week_expenses.dart';
import 'package:manage_expenses/features/data/providers/get_all_category_provider.dart';
import '../../components/expense_list_tile.dart';

class WeekExpense extends ConsumerWidget {
  const WeekExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekExpenses = ref.watch(allWeekExpensesProvider);
    final categories = ref.watch(getAllCateogryProvider);
    final brightness = ref.watch(systemBrightnessProvider(context));
    return weekExpenses.when(
      data: (expenses) {
        if (expenses.isEmpty) {
          // TODO: WORK ON AN ANIMATION FOR THIS SECTION
          return const SliverToBoxAdapter(
            child: Center(
              child: TitleText(
                text: "No Expense yet",
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
                String color = '#bcc0c4';
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
                  loading: () => const SliverToBoxAdapter(
                    child: CircularProgressIndicator(),
                  ),
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
      error: (e, stk) => SliverToBoxAdapter(child: Container()),
      loading: () => SliverToBoxAdapter(
        child: Container(),
      ),
    );
  }
}
