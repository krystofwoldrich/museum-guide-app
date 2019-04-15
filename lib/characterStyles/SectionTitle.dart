import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String _content;

  SectionTitle(this._content);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      this._content,
      style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
    );
  }
}