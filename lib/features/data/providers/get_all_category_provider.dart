import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../database/models/category.dart';
import 'database_provider.dart';

final getAllCateogryProvider =
    StreamProvider.autoDispose<List<Category>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.getAllCategories();
});
