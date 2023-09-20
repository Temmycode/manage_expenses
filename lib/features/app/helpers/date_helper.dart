class DateHelper {
// function for all the weeks in a years interval from today
  List<List<DateTime>> getAllWeeksInYearInterval() {
    List<DateTime> week = getTheWeekStartAndEnd();
    DateTime startOfThisWeek;
    DateTime endOfThisWeek;
    if (week[0].isAfter(week[1])) {
      startOfThisWeek = week[1];
      endOfThisWeek = week[0];
    } else {
      startOfThisWeek = week[0];
      endOfThisWeek = week[1];
    }
    List<List<DateTime>> weeks = [];
    weeks.add([startOfThisWeek, endOfThisWeek]);

    for (int i = 0; i < 52; i++) {
      startOfThisWeek = startOfThisWeek.subtract(const Duration(days: 7));
      endOfThisWeek = endOfThisWeek.subtract(const Duration(days: 7));
      weeks.add([startOfThisWeek, endOfThisWeek]);
    }
    return weeks;
  }

// function to get todays week
  List<DateTime> getTheWeekStartAndEnd() {
    final DateTime today = DateTime.now();
    List<DateTime> weeks = [];
    for (int i = 0; i < 7; i++) {
      if (today.subtract(Duration(days: i)).weekday == 7) {
        weeks.add(today.subtract(Duration(days: i)));
      }
      if (today.add(Duration(days: i)).weekday == 6) {
        weeks.add(today.add(Duration(days: i)));
      }
    }
    return weeks;
  }

// function to calculate the months of the year

// function to calculate the months of the year
  List<List<DateTime>> getTheMonths() {
    final date = DateTime.now();
    final today = DateTime(date.year, date.month, 1);
    List<List<DateTime>> month = [];
    for (int i = 0; i < 12; i++) {
      final newDate = DateTime(today.year, today.month - i);
      if (newDate.month == DateTime.september ||
          newDate.month == DateTime.april ||
          newDate.month == DateTime.june ||
          newDate.month == DateTime.november) {
        final monthEnd = newDate.add(const Duration(days: 29));
        month.add([newDate, monthEnd]);
      } else if (newDate.month == DateTime.january ||
          newDate.month == DateTime.march ||
          newDate.month == DateTime.may ||
          newDate.month == DateTime.july ||
          newDate.month == DateTime.august ||
          newDate.month == DateTime.october ||
          newDate.month == DateTime.december) {
        final monthEnd = newDate.add(const Duration(days: 30));
        month.add([newDate, monthEnd]);
      } else if (newDate.month == DateTime.february) {
        final monthEnd = newDate.add(const Duration(days: 27));
        month.add([newDate, monthEnd]);
      }
    }
    return month;
  }

  List<DateTime> getTheBeginningAndEndOfThisMonth() {
    final date = DateTime.now();
    final today = DateTime(date.year, date.month, date.day);
    List<DateTime> month = [];
    if (today.month == DateTime.september ||
        today.month == DateTime.april ||
        today.month == DateTime.june ||
        today.month == DateTime.november) {
      final monthStart = DateTime(today.year, today.month, 1);
      final monthEnd = DateTime(today.year, today.month, 30);
      month = [monthStart, monthEnd];
    } else if (today.month == DateTime.january ||
        today.month == DateTime.march ||
        today.month == DateTime.may ||
        today.month == DateTime.july ||
        today.month == DateTime.august ||
        today.month == DateTime.october ||
        today.month == DateTime.december) {
      final monthStart = DateTime(today.year, today.month, 1);
      final monthEnd = DateTime(today.year, today.month, 31);
      month = [monthStart, monthEnd];
    } else if (today.month == DateTime.february) {
      final monthStart = DateTime(today.year, today.month, 1);
      final monthEnd = DateTime(today.year, today.month, 28);
      month = [monthStart, monthEnd];
    }
    return month;
  }
}
