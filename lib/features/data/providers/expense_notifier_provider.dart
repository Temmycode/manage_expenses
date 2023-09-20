import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../notifiers/expense_notifiers.dart';

final expenseNotifierProvider = StateNotifierProvider<ExpenseNotifier, void>(
  (ref) => ExpenseNotifier(ref: ref),
);
