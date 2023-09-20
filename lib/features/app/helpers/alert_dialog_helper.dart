import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage_expenses/features/app/utils/text/small_text.dart';
import 'package:manage_expenses/features/app/utils/text/title_text.dart';

alertDialogHelper(BuildContext context, String text, String title,
    {required VoidCallback ok}) {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: TitleText(text: title),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleText(
            weight: FontWeight.normal,
            text: text,
            size: 16,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: ok,
            child: const Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: SmallText(
                    text: "OK",
                    color: CupertinoColors.activeBlue,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: SmallText(
                      text: "Cancel",
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
