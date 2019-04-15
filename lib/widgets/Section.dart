import 'package:flutter/material.dart';
import '../characterStyles/SectionTitle.dart';

class Section extends StatelessWidget {
  final bool isRow;
  final String title;
  final List<Widget> content;

  Section({
    this.title,
    @required this.content,
    this.isRow = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this._getSectionBody(),
      ),
    );
  }

  List<Widget> _getSectionBody() {
    List<Widget> sectionBody = [];

    if (title != null) {
      sectionBody.add(SectionTitle(title));
    }

    if (isRow) {
      sectionBody.add(Row(children: content));
    } else {
      sectionBody.add(Column(children: content));
    }

    return sectionBody;
  }
}