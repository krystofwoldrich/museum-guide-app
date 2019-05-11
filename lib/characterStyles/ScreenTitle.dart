import 'package:flutter/material.dart';
import 'package:museum_guide_app/theme/theme.dart';

class ScreenTitle extends StatelessWidget {
  final String _content;

  ScreenTitle(this._content);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this._content,
        style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
      ),
      margin: EdgeInsets.only(left: layoutMarginLeft),
    );
  }
}
