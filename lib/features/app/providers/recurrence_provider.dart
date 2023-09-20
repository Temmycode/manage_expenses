import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/utils/enums/recurence_enum.dart';

final recurrenceProvider = StateProvider<Recurrence>((ref) => Recurrence.none);
