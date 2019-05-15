import 'package:flutter/material.dart';
import 'package:museum_guide_app/model/Multimedia.dart';
import 'package:museum_guide_app/widgets/cards/localCardDecoration.dart';
import 'package:museum_guide_app/widgets/cards/localCardTheme.dart';

class StepCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String coverPictureUrl;
  final List<Multimedia> multimedias;
  final void Function() onTap;

  StepCard({
    @required this.id,
    @required this.title,
    @required this.description,
    this.multimedias,
    this.coverPictureUrl,
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
      Text(
        this.description != null ? this.description : 'No description',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
      )
    ];

    print(this.multimedias);
    if (this.multimedias != null && this.multimedias.length >= 1 && this.multimedias[0].type == 'audio') {
      content.add(Icon(
        Icons.play_arrow,
        size: 54,
        color: Theme.of(context).primaryColor,
      ));
    } else {
      content.add(Container(
        height: 54,
        margin: EdgeInsets.all(8),
      ));
    }

    return withCustomTheme(context, Card(
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
              bottom: 30,
            ),
            decoration: getDecoration(
              context,
              fallbackAssetImageUrl: 'images/exhibition-card-missing-cover.jpg',
              imageUrl: this.coverPictureUrl,
            ),
          ),
          onTap: this.onTap
        ),
      ));
  }
}