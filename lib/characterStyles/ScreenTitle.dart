import 'package:flutter/material.dart';
import 'package:museum_guide_app/theme/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ScreenTitle extends StatelessWidget {
  final String _content;

  ScreenTitle(this._content);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AutoSizeText(
        this._content,
        style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
        minFontSize: 38,
        maxLines: 2,
      ),
      margin: EdgeInsets.only(left: layoutMarginLeft),
    );
  }
}
