import 'package:flutter/material.dart';

Widget withCustomTheme(BuildContext context, Widget widget) {
  return Theme(
    data: Theme.of(context).copyWith(
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    child: widget,
  );  
}