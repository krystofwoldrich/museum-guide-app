import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String _content;

  ScreenTitle(this._content);

  @override
  Widget build(BuildContext context) {
    return Text(
      this._content,
      style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
    );
  }
}
