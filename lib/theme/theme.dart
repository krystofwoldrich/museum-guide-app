import 'package:flutter/material.dart';

final Color _colorGrey = Color.fromRGBO(240, 240, 240, 1);
final Color _colorDarkGrey = Color.fromRGBO(64, 64, 64, 1);
final Color _colorRed = Color.fromRGBO(128, 0, 0, 1);

final ThemeData customThemeData =
  ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.light,
    primaryColor: _colorRed,
    accentColor: _colorRed,
    canvasColor: _colorGrey,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: _colorDarkGrey,
      elevation: 0,
      textTheme: TextTheme(
        body1: TextStyle(
          color: _colorDarkGrey,
        ),
      ),
    ),
    textTheme: TextTheme(
      body1: TextStyle(
        color: _colorDarkGrey
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22)),
        side: BorderSide(color: _colorRed, width: 1),
      ),
      buttonColor: _colorRed,
      colorScheme: ColorScheme.dark(),
    ),
  );
