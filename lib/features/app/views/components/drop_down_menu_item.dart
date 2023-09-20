import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/extensions/capitalize_extenstion.dart';
import 'package:manage_expenses/features/app/providers/expense_of_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/expense_of_enum.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';

class DropDownMenuButton extends ConsumerWidget {
  const DropDownMenuButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.grey.withOpacity(0.4)
            : Colors.grey.shade300.withOpacity(0.5),
      ),
      child: DropdownButton(
        iconEnabledColor: Colors.blue,
        underline: const Divider(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        value: ref.watch(expenseOfProvider),
        items: ExpenseOf.values
            .map(
              (value) => DropdownMenuItem(
                value: value,
                child: SmallText(
                  text: value.capitalize(value.name),
                  color: Colors.blue,
                ),
              ),
            )
            .toList(),
        onChanged: (ExpenseOf? value) =>
            ref.read(expenseOfProvider.notifier).state = value!,
      ),
    );
  }
}
