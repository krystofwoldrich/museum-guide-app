import 'package:flutter/material.dart';
import '../characterStyles/SectionTitle.dart';

class Section extends StatelessWidget {
  final bool isRow;
  final String title;
  final List<Widget> content;

  final String onMoreTitle;
  final void Function() onMore;

  Section({
    this.title,
    @required this.content,
    this.isRow = false,
    this.onMoreTitle = 'Show More',
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this._getSectionBody(context),
      ),
    );
  }

  List<Widget> _getSectionBody(BuildContext context) {
    List<Widget> sectionBody = [];

    if (title != null) {
      sectionBody.add(this._getHeader(context));
    }

    if (isRow) {
      sectionBody.add(Container(
        width: double.infinity,
        height: 102,
        child:  ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: this.content,
        ),
      ));
    } else {
      sectionBody.add(Column(
        children: this.content
          .map((Widget item) => SizedBox(
            width: double.infinity, 
            child: item,
          ))
          .toList()
      ));
    }

    return sectionBody;
  }

  Widget _getHeader(BuildContext context) {
    final List<Widget> content = [SectionTitle(title)];

    if (this.onMore != null) {
      content.add(FlatButton(
        child: Text(
          this.onMoreTitle.toUpperCase(),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: this.onMore,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: content,
    );
  }
}