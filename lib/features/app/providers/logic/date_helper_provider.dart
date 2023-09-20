import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/helpers/date_helper.dart';

final dateHelperProvider = Provider<DateHelper>((ref) => DateHelper());
