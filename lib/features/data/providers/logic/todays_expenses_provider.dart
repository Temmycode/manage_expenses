import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/data/database/models/expense.dart';
import 'package:manage_expenses/features/data/providers/database_provider.dart';

final todaysExpensesProvider = StreamProvider.autoDispose<double>(
  (ref) async* {
    final db = ref.watch(databaseProvider).getAllTodaysExpense();
    double result = 0;
    List<Expense> expenses = [];
    await for (var expense in db) {
      expenses.addAll(expense);
      for (var expense in expenses) {
        result += expense.price;
      }
      yield result;
    }
  },
);
