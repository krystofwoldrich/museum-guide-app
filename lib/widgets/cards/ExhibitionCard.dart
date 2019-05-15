import 'package:flutter/material.dart';
import 'package:museum_guide_app/screens/ExhibitionDetail.dart';
import 'package:museum_guide_app/widgets/cards/localCardDecoration.dart';
import 'package:museum_guide_app/widgets/cards/localCardTheme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ExhibitionCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String coverPictureUrl;
  final DateTime from;
  final DateTime to;

  ExhibitionCard({
    @required this.id,
    @required this.title,
    @required this.description,
    this.coverPictureUrl,
    this.from,
    this.to
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
      Text(
        this.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
      ),
    ];

    if (this.description != null) {
      content.add(Container(
        child: AutoSizeText(
          this.description,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          minFontSize: 14,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        margin: EdgeInsets.only(top: 16),
      ));
    }

    return withCustomTheme(context, Container(
      child: Card(
        child: InkWell(
          child: Container(
            child: Column(
              children: content,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            padding: EdgeInsets.only(
              left: 16,
              top: 16,
              right: 24,
              bottom: 30,
            ),
            decoration: getDecoration(
              context, 
              fallbackAssetImageUrl: 'images/exhibition-card-missing-cover.jpg', 
              imageUrl: this.coverPictureUrl
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ExhibitionDetail(exhibitionId: this.id,),
            ));
          },
        ),
      ),
    ));
  }
}