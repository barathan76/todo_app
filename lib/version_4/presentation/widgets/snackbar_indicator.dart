import 'package:flutter/material.dart';
import 'package:todo_app/version_4/presentation/widgets/color_scheme.dart';

SnackBar snackBarIndicator(
  String text,
  void Function() undo,
  BuildContext context,
) {
  return SnackBar(
    content: Text(
      "Task is ${text}ed",
      style: TextStyle(color: primaryTextColor(context)),
    ),
    backgroundColor: onPrimaryColor(context),
    action: SnackBarAction(
      textColor: primaryTextColor(context),
      label: 'Undo',
      onPressed: () {
        undo();
      },
    ),
    duration: Duration(seconds: 3),
  );
}
