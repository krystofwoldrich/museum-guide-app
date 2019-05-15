import 'package:flutter/material.dart';
import 'package:museum_guide_app/theme/theme.dart';
import '../characterStyles/SectionTitle.dart';

class Section extends StatelessWidget {
  final bool isRow;
  final String title;
  final String description;
  final List<Widget> content;

  final String onMoreTitle;
  final void Function() onMore;

  Section({
    this.title,
    this.description,
    this.content,
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
      margin: EdgeInsets.only(
        bottom: 16,
      ),
    );
  }

  List<Widget> _getSectionBody(BuildContext context) {
    List<Widget> sectionBody = [];

    if (title != null) {
      sectionBody.add(this._getHeader(context));
    }

    if (this.content == null) return sectionBody;

    if (isRow) {
      sectionBody.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: this.content,
            ),
          ),
        ],
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
    final List<Widget> headerContent = [SectionTitle(title)];

    if (this.onMore != null) {
      headerContent.add(FlatButton(
        child: Text(
          this.onMoreTitle.toUpperCase(),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: this.onMore,
      ));
    }

    final descriptionContent = this.description == null
      ? Container()
      : Container(
        alignment: Alignment.topLeft,
        child: Text(
          this.description,
          style: Theme.of(context).textTheme.body1,
        ),
      );

    return Container(
      child: Column(
        children: <Widget>[
         Container(
           child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: headerContent,
            ),
            margin: EdgeInsets.only(bottom: 4),
         ),
          descriptionContent
        ],
      ),
      margin: EdgeInsets.only(
        left: layoutMarginLeft, 
        right: layoutMarginRight  
      ),
    );
  }
}