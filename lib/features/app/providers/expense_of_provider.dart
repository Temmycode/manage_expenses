import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/utils/enums/expense_of_enum.dart';

final expenseOfProvider = StateProvider<ExpenseOf>((ref) => ExpenseOf.day);
