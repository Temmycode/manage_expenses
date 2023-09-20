import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/system_brightness_provider.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';
import 'package:manage_expenses/features/data/providers/all_expenses/get_all_today_expense.dart';
import 'package:manage_expenses/features/data/providers/expense_notifier_provider.dart';
import 'package:manage_expenses/features/data/providers/get_all_category_provider.dart';
import '../../components/expense_list_tile.dart';

class DayExpense extends ConsumerWidget {
  const DayExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(systemBrightnessProvider(context));
    final todaysExpenses = ref.watch(getAllTodaysExpenseProvider);
    final categories = ref.watch(getAllCateogryProvider);
    return todaysExpenses.when(
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
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              await ref
                                  .read(expenseNotifierProvider.notifier)
                                  .deleteExpense(
                                    expenses[index],
                                  );
                            },
                            label: "Delete",
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      child: ExpenseListTile(
                        category: expenses[index].category,
                        name: expenses[index].title,
                        date: expenses[index].date,
                        price: expenses[index].price,
                        categoryColor: color,
                      ),
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
