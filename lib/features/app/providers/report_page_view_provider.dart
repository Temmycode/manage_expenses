import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/logic/all_months_in_a_year_provider.dart';
import 'package:manage_expenses/features/app/providers/logic/all_weeks_in_a_year_provider.dart';

final reportWeekPageProvider = Provider.autoDispose<PageController>(
  (ref) {
    final dates = ref.read(allWeeksInAYearProvider);
    final pageView = PageController(initialPage: dates.length - 1);
    ref.onDispose(() {
      pageView.dispose();
    });
    return pageView;
  },
);

final reportMonthPageProvider = Provider.autoDispose<PageController>((ref) {
  final dates = ref.read(allMonthsInAYearProvider);
  final pageView = PageController(initialPage: dates.length - 1);
  ref.onDispose(() {
    pageView.dispose();
  });
  return pageView;
});
