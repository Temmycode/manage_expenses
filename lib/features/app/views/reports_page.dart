import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/logic/all_months_in_a_year_provider.dart';
import 'package:manage_expenses/features/app/providers/logic/all_weeks_in_a_year_provider.dart';
import 'package:manage_expenses/features/app/providers/report_page_enum_provider.dart';
import 'package:manage_expenses/features/app/providers/report_page_view_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/report_page_section_enum.dart';
import 'package:manage_expenses/features/app/views/components/report_screen_model.dart';

class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// THIS SCREEN IS A PAGE VIEW OF THE REPORT SCREEN ITSELF
    /// IT WILL SUFFLE BETWEEN MONTH AND WEEK PAGE ALSO
    final weeksInYear = ref.watch(allWeeksInAYearProvider);
    final monthsInYear = ref.watch(allMonthsInAYearProvider);
    final weekPageController = ref.watch(reportWeekPageProvider);
    final monthPageController = ref.watch(reportMonthPageProvider);
    final section = ref.watch(reportPageEnumProvider);
    return Scaffold(
      body: section == ReportPageSections.week
          ? PageView.builder(
              controller: weekPageController,
              itemCount: weeksInYear.length,
              itemBuilder: (context, index) {
                final i = 52 - index;
                return ReportPageModel(
                  weekEnd: weeksInYear[i][1],
                  weekStart: weeksInYear[i][0],
                );
              },
            )
          : PageView.builder(
              controller: monthPageController,
              itemCount: monthsInYear.length,
              itemBuilder: (context, index) {
                final i = 11 - index;
                return ReportPageModel(
                  monthStart: monthsInYear[i][0],
                  monthEnd: monthsInYear[i][1],
                );
              },
            ),
    );
  }
}
