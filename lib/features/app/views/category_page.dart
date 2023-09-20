import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';
import '../../data/providers/expense_notifier_provider.dart';
import '../../data/providers/get_all_category_provider.dart';
import '../providers/theme/dark_mode_provider.dart';
import '../utils/enums/dark_mode_enum.dart';
import '../utils/text/title_text.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  late final TextEditingController _newCategoryController;
  Color currentColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _newCategoryController = TextEditingController();
  }

  @override
  void dispose() {
    _newCategoryController.dispose();
    super.dispose();
  }

  changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  showColorPicker(BuildContext context, Color currentColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const TitleText(
            text: "Pick a color",
            weight: FontWeight.w500,
            size: 16,
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: SmallText(
                text: "Ok",
                color: currentColor,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // all cateogry provider
    final categories = ref.watch(getAllCateogryProvider);
    final brightness = ref.watch(darkModeProvider);
    final isDarkMode = brightness == DarkMode.dark ||
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Colors.black : CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor:
            isDarkMode ? Colors.black : CupertinoColors.systemGroupedBackground,
        centerTitle: false,
        elevation: 0,
        title: const TitleText(
          text: "Categories",
          size: 24,
        ),
      ),
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            // COLUMN FOR THE CATEGORIES:
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  // // ALL THE CATEGORIES IN THE SYSTEM:
                  categories.when(
                    data: (category) {
                      if (category.isEmpty) {
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            height: 650,
                            child: const TitleText(
                              text: "No Cateogries yet",
                              size: 18,
                              weight: FontWeight.w400,
                            ),
                          ),
                        );
                      } else {
                        return CupertinoFormSection.insetGrouped(
                          margin: EdgeInsets.zero,
                          children: category
                              .map(
                                (value) => Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                          // the delete function:
                                          onPressed: (context) {
                                            ref
                                                .read(
                                                  expenseNotifierProvider
                                                      .notifier,
                                                )
                                                .deleteACategory(value);
                                          },
                                          icon: CupertinoIcons.delete,
                                          backgroundColor: Colors.red,
                                          borderRadius: value == category.first
                                              ? const BorderRadius.only(
                                                  topRight: Radius.circular(8))
                                              : value == category.last
                                                  ? const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(8))
                                                  : BorderRadius.zero),
                                    ],
                                  ),
                                  child: CupertinoListTile(
                                    leading: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: HexColor(value.color),
                                      ),
                                    ),
                                    title: TitleText(
                                      text: value.categoryName,
                                      size: 16,
                                      weight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                    error: (error, stk) => Container(),
                    loading: () => Container(),
                  ),
                ],
              ),
            ),

            // // CATEGORY ADD:
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        placeholder: "New category",
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                        controller: _newCategoryController,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isDarkMode
                              ? CupertinoColors.secondarySystemBackground
                              : CupertinoColors.opaqueSeparator,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // COLOR PICKER:
                    GestureDetector(
                      onTap: () {
                        showColorPicker(context, currentColor);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: currentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    //     // ADD NEW CATEGORY:
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(expenseNotifierProvider.notifier)
                            .createNewCategory(
                              currentColor,
                              _newCategoryController.text,
                            );
                        _newCategoryController.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CupertinoColors.activeBlue,
                        ),
                        child: const Icon(CupertinoIcons.arrow_up),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
