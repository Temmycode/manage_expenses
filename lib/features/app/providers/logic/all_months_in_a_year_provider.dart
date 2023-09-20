import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/providers/logic/date_helper_provider.dart';

final allMonthsInAYearProvider = Provider<List<List<DateTime>>>(
  (ref) => ref.read(dateHelperProvider).getTheMonths(),
);
