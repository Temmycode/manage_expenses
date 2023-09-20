import 'package:isar/isar.dart';
part 'expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late DateTime date;
  late double price;
  late String title;
  late String recurrence;
  late String description;
  late String category;

  @override
  String toString() =>
      'Expense(id: $id, date: $date, price: $price, title: $title, recurrence: $recurrence, description: $description, category: $category)';
}
