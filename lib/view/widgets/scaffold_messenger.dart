import 'package:flutter/material.dart';

showSnackBar({BuildContext? context,Color? textcolor,Color? backgroundColor,String? text}) {
  return ScaffoldMessenger.of(context!).showSnackBar(
     SnackBar(
      content: Text(
        text??'',
        style: TextStyle(color: textcolor),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}