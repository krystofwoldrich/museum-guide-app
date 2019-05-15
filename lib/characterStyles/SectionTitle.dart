import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SectionTitle extends StatelessWidget {
  final String _content;

  SectionTitle(this._content);
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AutoSizeText(
        this._content,
        style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
        minFontSize: 28,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}