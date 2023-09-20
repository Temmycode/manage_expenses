import 'package:isar/isar.dart';
part 'category.g.dart';

@Collection()
class Category {
  final Id id = Isar.autoIncrement;
  @Index(unique: true, replace: false)
  late String categoryName;
  late final String color;

  @override
  String toString() =>
      'Category(id: $id, categoryName: $categoryName, color: $color)';
}
