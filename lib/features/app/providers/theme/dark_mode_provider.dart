import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/utils/enums/dark_mode_enum.dart';

final darkModeProvider = StateProvider<DarkMode>((ref) => DarkMode.system);
