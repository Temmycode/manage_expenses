import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/data/database/models/expense.dart';
import 'package:manage_expenses/features/data/providers/database_provider.dart';

final getAllTodaysExpenseProvider =
    StreamProvider.autoDispose<List<Expense>>((ref) {
  final todayExpense = ref.watch(databaseProvider).getAllTodaysExpense();
  return todayExpense;
});
