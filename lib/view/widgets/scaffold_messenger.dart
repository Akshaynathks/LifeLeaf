import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

showSnackBar(
    {BuildContext? context,
    Color? textcolor,
    Color? backgroundColor,
    String? text}) {
  return ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      content: Text(
        text ?? '',
        style: TextStyle(color: textcolor),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}

Future<bool> showDeleteConfirmation(BuildContext context) async {
  return await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Delete',
      text: 'Are you sure you want to delete this item?',
      cancelBtnText: 'Cancel',
      onCancelBtnTap: () {
        Navigator.of(context).pop(false);
      },
      onConfirmBtnTap: () {
        Navigator.of(context).pop(true);
      });
}

Future<bool> showCompleateConfirmation(BuildContext context) async {
  return await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Confirmation',
      text: 'Are you sure you want to mark this habit as completed?',
      cancelBtnText: 'Cancel',
      onCancelBtnTap: () {
        Navigator.of(context).pop(false);
      },
      onConfirmBtnTap: () {
        Navigator.of(context).pop(true);
      });
}
