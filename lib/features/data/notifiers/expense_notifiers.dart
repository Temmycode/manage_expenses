import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/data/notifiers/extensions/color_to_string_extension.dart';
import '../database/models/category.dart';
import '../database/models/expense.dart';
import '../providers/database_provider.dart';

class ExpenseNotifier extends StateNotifier<void> {
  final Ref ref;
  ExpenseNotifier({required this.ref}) : super(Void);

  // FUNCTION TO ADD A NEW EXPENSE:
  Future<void> createNewExpense(Expense expense) async {
    await ref.read(databaseProvider).addExpense(expense);
  }

  // FUNCTION TO DELETE AN EXPENSE:
  Future<void> deleteExpense(Expense expense) async {
    await ref.read(databaseProvider).deleteExpense(expense);
  }

  // FUNCTION TO CLEAR THE DATABASE:
  Future<void> clearDatabase() async {
    await ref.read(databaseProvider).clearDatabase();
  }

  // FUNCTION TO CREATE A NEW CATEOGRY:
  Future<void> createNewCategory(Color color, String name) async {
    final db = ref.read(databaseProvider);
    final hexColor = color.string();
    final category = Category()
      ..color = hexColor
      ..categoryName = name;
    await db.createCategory(category);
  }

  Future<void> deleteACategory(Category category) async {
    final db = ref.read(databaseProvider);
    await db.deleteCateory(category);
  }
}
