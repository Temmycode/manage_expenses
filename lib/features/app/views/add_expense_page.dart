import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:manage_expenses/features/app/helpers/alert_dialog_helper.dart';
import 'package:manage_expenses/features/app/helpers/drop_down_helper.dart';
import 'package:manage_expenses/features/app/providers/date_provider.dart';
import 'package:manage_expenses/features/app/providers/recurrence_provider.dart';
import 'package:manage_expenses/features/app/utils/enums/recurence_enum.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';
import 'package:manage_expenses/features/data/providers/expense_notifier_provider.dart';
import '../../data/database/models/category.dart';
import '../../data/database/models/expense.dart';
import '../../data/providers/get_all_category_provider.dart';
import '../providers/theme/dark_mode_provider.dart';
import '../utils/enums/dark_mode_enum.dart';

class AddExpensePage extends ConsumerStatefulWidget {
  const AddExpensePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<AddExpensePage> {
  late final TextEditingController _amountController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  String currentCategory = 'Select Category';

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void pickDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: CupertinoDatePicker(
            initialDateTime: ref.watch(dateProvider),
            onDateTimeChanged: (value) =>
                ref.read(dateProvider.notifier).state = value,
          ),
        );
      },
    );
  }

  void pickCategory(BuildContext context, List<Category> category) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          height: 300,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (value) => setState(() {
              currentCategory = category[value].categoryName;
            }),
            children: category
                .map(
                  (category) => CupertinoListTile(
                    leading: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: HexColor(category.color),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    title: TitleText(
                      text: category.categoryName,
                      weight: FontWeight.w400,
                      size: 20,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  reset() {
    _descriptionController.clear();
    _titleController.clear();
    _amountController.clear();
    ref.read(recurrenceProvider.notifier).state = Recurrence.none;
    ref.read(dateProvider.notifier).state = DateTime.now();
    setState(() {
      currentCategory = 'Select Category';
    });
  }

  @override
  Widget build(BuildContext context) {
    final today = ref.watch(dateProvider);
    final formattedDate = DateFormat('MMM d, y').format(today);
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    // CATEGORY PROVIDER:
    final categories = ref.watch(getAllCateogryProvider);
    // RECURRENCE PROVIDER:
    final recurrence = ref.watch(recurrenceProvider);
    return Scaffold(
      backgroundColor:
          isDarkMode ? Colors.black : CupertinoColors.systemGroupedBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TitleText(
                    text: "Add",
                    size: 24,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CupertinoFormSection.insetGrouped(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  children: [
                    // AMOUNT:
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Amount",
                          color: isDarkMode ? Colors.white : Colors.black,
                          weight: FontWeight.w600,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: CupertinoTextField.borderless(
                          controller: _amountController,
                          placeholder: "Amount",
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.end,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),

                    // NAME OF EXPENSE:
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Title",
                          color: isDarkMode ? Colors.white : Colors.black,
                          weight: FontWeight.w600,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: CupertinoTextField.borderless(
                          controller: _titleController,
                          placeholder: "Title",
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.end,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),

                    // RECURENCE:
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Recurrence",
                          weight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        helper: null,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        // DROP DOWN FOR RECURRENCE:
                        child: const RecurrenceDropDown(),
                      ),
                    ),

                    // DATE:
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Date",
                          weight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: GestureDetector(
                          onTap: () {
                            pickDate(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: isDarkMode
                                  ? Colors.grey.shade200.withOpacity(0.2)
                                  : CupertinoColors.systemGroupedBackground,
                            ),
                            child: SmallText(text: formattedDate),
                          ),
                        ),
                      ),
                    ),

                    // DESCRIPTION OR NOTE:
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Note",
                          weight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: CupertinoTextField.borderless(
                          controller: _descriptionController,
                          placeholder: "Note",
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.end,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),

                    // CATEGORY:
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: SmallText(
                          text: "Category",
                          weight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        helper: null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: categories.when(
                          data: (category) {
                            if (category.isNotEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  pickCategory(context, category);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: isDarkMode
                                        ? Colors.grey.shade200.withOpacity(0.2)
                                        : CupertinoColors
                                            .systemGroupedBackground,
                                  ),
                                  child: SmallText(text: currentCategory),
                                ),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: isDarkMode
                                      ? Colors.grey.shade200.withOpacity(0.2)
                                      : CupertinoColors.systemGroupedBackground,
                                ),
                                child: const SmallText(text: "No category"),
                              );
                            }
                          },
                          error: (error, stk) => Container(),
                          loading: () => Container(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                categories.when(
                  data: (value) {
                    if (value.isEmpty) {
                      return CupertinoButton.filled(
                        onPressed: () {
                          alertDialogHelper(
                            context,
                            "You don't have any categories yet",
                            "No categories",
                            ok: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: const TitleText(
                          text: "Add",
                          weight: FontWeight.w400,
                          size: 18,
                          color: Colors.white30,
                        ),
                      );
                    } else {
                      return CupertinoButton.filled(
                        onPressed: () async {
                          if (_descriptionController.text.isEmpty ||
                              _titleController.text.isEmpty ||
                              _amountController.text.isEmpty) {
                          } else {
                            log(today.toString());
                            final expense = Expense()
                              ..category = currentCategory
                              ..description = _descriptionController.text
                              ..date = today
                              ..price = double.parse(_amountController.text)
                              ..recurrence = recurrence.toString().toLowerCase()
                              ..title = _titleController.text;

                            await ref
                                .read(expenseNotifierProvider.notifier)
                                .createNewExpense(expense)
                                .whenComplete(
                                  () =>
                                      // reset all parameters
                                      reset(),
                                );
                          }
                        },
                        child: const TitleText(
                          text: "Add",
                          weight: FontWeight.w400,
                          size: 18,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                  error: (error, stk) => Container(),
                  loading: () => Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
