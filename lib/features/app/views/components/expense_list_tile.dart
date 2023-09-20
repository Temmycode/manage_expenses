import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';
import 'package:manage_expenses/features/app/utils/typedefs/category_typedef.dart';

class ExpenseListTile extends StatelessWidget {
  final String categoryColor;
  final Category category;
  final String name;
  final DateTime date;
  final double price;
  const ExpenseListTile({
    super.key,
    required this.category,
    required this.name,
    required this.date,
    required this.price,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().day;
    final String timeDate = "${date.hour}:${date.minute}";
    final String formattedDate = DateFormat('EEE, d/M/y').format(date);
    return CupertinoListTile(
      title: TitleText(
        text: name,
        size: 18,
      ),
      subtitle: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? HexColor(categoryColor).withOpacity(0.5)
              : HexColor(categoryColor),
        ),
        child: SmallText(
          text: category,
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? HexColor(categoryColor)
              : Colors.white,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TitleText(
            text: '\$${price.toStringAsFixed(2)}',
            size: 18,
          ),
          SmallText(
            text: today == date.day ? timeDate : formattedDate,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
