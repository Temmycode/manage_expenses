import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:manage_expenses/features/app/providers/logic/date_helper_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'models/category.dart';
import 'models/expense.dart';

class Database {
  Ref ref;
  Database({required this.ref});
  Isar? _db;

  Future<Isar> get db async {
    if (_db == null) {
      _db = await openDb();
      return _db!;
    }
    return _db!;
  }

  /////////////////////////////////////////////////////////////////////////////
  /*
  REPORT SCREEN EXPENSE DATA:

  getWeekExpense() {}

  getMonthExpense() {}
   */
  // the weekly report screen expenses
  Stream<List<Expense>> getReportWeekExpense(
    DateTime start,
    DateTime end,
  ) async* {
    final isar = await db;
    yield* isar.txnSync(
      () => isar.expenses
          .where()
          .filter()
          .dateBetween(start, end)
          .watch(fireImmediately: true),
    );
  }

  // the monthly report screen expenses
  Stream<List<Expense>> getReportMonthExpense(
    DateTime start,
    DateTime end,
  ) async* {
    final isar = await db;
    // final start = date[0];
    yield* isar.txnSync(
      () => isar.expenses
          .where()
          .filter()
          .dateBetween(start, end)
          .watch(fireImmediately: true),
    );
  }
  /////////////////////////////////////////////////////////////////////////////

  // FUNCTOIN TO CREATE A NEW EXPENSE:
  Future<void> addExpense(Expense expense) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.expenses.putSync(expense));
  }

  // FUNCTION TO DELETE AN EXPENSE:
  Future<void> deleteExpense(Expense expense) async {
    final isar = await db;
    isar.writeTxnSync(
      () => isar.expenses.deleteSync(expense.id),
    );
  }

  // FUNCTION TO CREATE A NEW CATEGORY:
  Future<void> createCategory(Category category) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.categorys.putSync(category));
  }

  // FUNCTION TO GET ALL THE CATEGORIES:
  Stream<List<Category>> getAllCategories() async* {
    final isar = await db;
    yield* isar.txnSync(
      () => isar.categorys.where().watch(fireImmediately: true),
    );
  }

  // FUNCTION TO DELETE A PARTICULAR CATEGORY:
  Future<void> deleteCateory(Category category) async {
    final isar = await db;
    isar.writeTxnSync(
      () => isar.categorys.deleteByCategoryNameSync(category.categoryName),
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  // FUNCTION TO GET ALL THE EXPENSES FOR A today
  Stream<List<Expense>> getAllTodaysExpense() async* {
    final isar = await db;
    final today = DateTime.now();
    final formattedDate = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(
        formattedDate.year, formattedDate.month, formattedDate.day, 24);
    yield* isar.txnSync(
      () => isar.expenses
          .where()
          .filter()
          .dateBetween(formattedDate, endOfDay)
          .watch(fireImmediately: true),
    );
  }

  Future<List<Expense>> calculateAllTodaysExpenses() async {
    final isar = await db;
    final today = DateTime.now();
    final formattedDate = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(
        formattedDate.year, formattedDate.month, formattedDate.day, 24);
    return isar.txnSync(
      () => isar.expenses
          .where()
          .filter()
          .dateBetween(formattedDate, endOfDay)
          .findAllSync(),
    );
  }

  // FUNCTION TO GET ALL THE EXPENSES FOR THE CURRENT WEEK:
  Stream<List<Expense>> getAllExpensesForAWeek() async* {
    final isar = await db;
    final weekInfo = ref.read(dateHelperProvider).getTheWeekStartAndEnd();
    DateTime week0;
    DateTime week1;
    if (weekInfo[0].isAfter(weekInfo[1])) {
      week0 = DateTime(weekInfo[1].year, weekInfo[1].month, weekInfo[1].day);
      week1 = DateTime(weekInfo[0].year, weekInfo[0].month, weekInfo[0].day);
    } else {
      week0 = DateTime(weekInfo[0].year, weekInfo[0].month, weekInfo[0].day);
      week1 = DateTime(weekInfo[1].year, weekInfo[1].month, weekInfo[1].day);
    }
    yield* isar.txnSync(
      () => isar.expenses
          .where()
          .filter()
          .dateBetween(week0, week1)
          .watch(fireImmediately: true),
    );
  }

  Stream<List<Expense>> calculateThisWeeksExpenses() async* {
    final isar = await db;
    final weekInfo = ref.read(dateHelperProvider).getTheWeekStartAndEnd();
    DateTime week0;
    DateTime week1;
    if (weekInfo[0].isAfter(weekInfo[1])) {
      week0 = weekInfo[1];
      week1 = weekInfo[0];
    } else {
      week0 = weekInfo[0];
      week1 = weekInfo[1];
    }
    yield* isar.txnSync(
      () => isar.expenses
          .where()
          .filter()
          .dateBetween(week0, week1)
          .watch(fireImmediately: true),
    );
  }

  // FUNCTION TO GET ALL THE EXPENSES FOR THE CURRENT MONTH
  Stream<List<Expense>> getAllExpenesForThisMonth() async* {
    final isar = await db;
    final month =
        ref.read(dateHelperProvider).getTheBeginningAndEndOfThisMonth();
    yield* isar.txnSync(
      () => isar.expenses
          .where()
          .filter()
          .dateBetween(month[0], month[1])
          .watch(fireImmediately: true),
    );
  }
  /////////////////////////////////////////////////////////////////////////////

  // FUNCTION TO CLEAR THE WHOLE DATABASE:
  Future<void> clearDatabase() async {
    final isar = await db;
    isar.writeTxnSync(() => isar.clearSync());
  }

  Future<Isar> openDb() async {
    final directory = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ExpenseSchema, CategorySchema],
        directory: directory.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
