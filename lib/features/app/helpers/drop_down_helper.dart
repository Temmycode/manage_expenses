import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/extensions/capitalize_extenstion.dart';
import 'package:manage_expenses/features/app/providers/recurrence_provider.dart';
import '../utils/enums/recurence_enum.dart';
import '../utils/text/small_text.dart';

class RecurrenceDropDown extends ConsumerWidget {
  const RecurrenceDropDown({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return DropdownButton(
      items: Recurrence.values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: SmallText(
                text: value.capitalize(value.name),
              ),
            ),
          )
          .toList(),
      value: ref.watch(recurrenceProvider),
      borderRadius: BorderRadius.circular(10),
      underline: const Divider(color: Colors.transparent),
      elevation: 1,
      onChanged: (value) =>
          ref.read(recurrenceProvider.notifier).state = value!,
    );
  }
}
