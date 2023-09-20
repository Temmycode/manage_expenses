import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/data/providers/database_provider.dart';
import '../../database/models/expense.dart';

final reportWeekExpenseProvider =
    StreamProvider.family.autoDispose<List<Expense>, String>(
  (ref, String date) {
    final db = ref.watch(databaseProvider);
    // serialize the incoming date and then turn it to dateTime
    final dateString = date.split('  ');
    final start = DateTime.parse(dateString[0]);
    final end = DateTime.parse(dateString[1]);
    // insert the new values in the function and return it
    return db.getReportWeekExpense(start, end);
  },
);
