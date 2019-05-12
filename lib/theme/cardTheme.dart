import 'package:flutter/material.dart';
import 'package:museum_guide_app/theme/theme.dart';

final CardTheme customCardTheme =
  CardTheme(
    color: Colors.white,
    elevation: 3,
    margin: EdgeInsets.only(
      left: layoutMarginLeft,
      top: 12,
      right: layoutMarginRight,
      bottom: 12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(22)),
    ),
    clipBehavior: Clip.antiAlias,
  );
