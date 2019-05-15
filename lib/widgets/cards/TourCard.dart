import 'package:flutter/material.dart';
import 'package:museum_guide_app/screens/TourDetail.dart';
import 'package:museum_guide_app/widgets/cards/localCardDecoration.dart';
import 'package:museum_guide_app/widgets/cards/localCardTheme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TourCard extends StatelessWidget {
  static const double maxLengthInHours = 6; //hours
  final String id;
  final String title;
  final String description;
  final double lengthInHours;
  final String coverImageUrl;
  final void Function() onTap;

  TourCard({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.lengthInHours,
    this.coverImageUrl,
    void Function() onTap,
  }) : this.onTap = onTap != null ? onTap : (() {}) ;

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
      Container(
        child: Text(
          this.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
        ),
        margin: EdgeInsets.only(
          bottom: 8,
        ),
      ),
    ];

    content.add(Container(
      child: AutoSizeText(
        this.description != null ? this.description : 'No description',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        minFontSize: 14,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      margin: EdgeInsets.only(
        bottom: 16,
      ),
    ));

    content.add(Text(
      this.lengthInHours != null ? '${this.lengthInHours} hour' : '',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
    ));

    content.add(
      FractionallySizedBox(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border.all(color: Theme.of(context).canvasColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          margin: EdgeInsets.only(
            top: 8,
            bottom: 8,
          ),
        ),
        widthFactor: this.lengthInHours/TourCard.maxLengthInHours,
      )
    );

    return withCustomTheme(context, Container(
      child: Card(
        child: InkWell(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
            padding: EdgeInsets.only(
              left: 16,
              top: 16,
              right: 24,
              bottom: 16,
            ),
            decoration: getDecoration(
              context,
              fallbackAssetImageUrl: 'images/exhibition-card-missing-cover.jpg',
              imageUrl: this.coverImageUrl,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TourDetail(tourId: this.id,),
            ));
          },
        ),
      ),
      width: MediaQuery.of(context).size.width*0.64,
  ));
  }
}