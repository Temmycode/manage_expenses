import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/data/database/models/expense.dart';
import 'package:manage_expenses/features/data/providers/database_provider.dart';

final allThisMonthsExpenseProvider = StreamProvider.autoDispose<List<Expense>>(
  (ref) {
    final expenses = ref.watch(databaseProvider).getAllExpenesForThisMonth();
    return expenses;
  },
);
