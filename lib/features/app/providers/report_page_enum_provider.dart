import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/utils/enums/report_page_section_enum.dart';

final reportPageEnumProvider = StateProvider<ReportPageSections>(
  (ref) => ReportPageSections.week,
);
