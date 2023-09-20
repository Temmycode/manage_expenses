import 'package:hooks_riverpod/hooks_riverpod.dart';

final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());
