import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../database/database.dart';

final databaseProvider = Provider<Database>((ref) => Database(ref: ref));
