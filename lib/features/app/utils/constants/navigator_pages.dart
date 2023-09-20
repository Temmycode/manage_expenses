import 'package:flutter/material.dart';
import 'package:manage_expenses/features/app/views/add_expense_page.dart';
import 'package:manage_expenses/features/app/views/all_expense_page/all_expense_page.dart';
import 'package:manage_expenses/features/app/views/reports_page.dart';
import 'package:manage_expenses/features/app/views/settings_page.dart';

const List<Widget> navigatorPages = [
  AllExpensePage(),
  ReportPage(),
  AddExpensePage(),
  SettingsPage(),
];
