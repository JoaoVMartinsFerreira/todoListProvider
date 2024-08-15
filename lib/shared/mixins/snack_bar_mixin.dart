import 'package:flutter/material.dart';
import 'package:todolist_app/shared/widgets/texts/text_widget.dart';

mixin SnackBarMixin {
  void showSnackBar(text,
      {required BuildContext context, bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: TextWidget(text),
          backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
        ),
      );
  }
}
