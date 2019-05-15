import 'package:flutter/material.dart';
import 'package:museum_guide_app/widgets/cards/localCardTheme.dart';

class ArtworkCard extends StatelessWidget {
  final String id;
  final String title;
  final String coverPictureUrl;
  final void Function() onTap;

  ArtworkCard({
    @required this.id,
    @required this.title,
    this.coverPictureUrl,
    void Function() onTap,
  }) : this.onTap = onTap != null ? onTap : (() {}) ;

  @override
  Widget build(BuildContext context) {
    return withCustomTheme(context, Card(
      child: InkWell(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  this.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                ),
                margin: EdgeInsets.only(
                  bottom: 8,
                ),
                height: 284,
              ),
            ],
          ),
          padding: EdgeInsets.only(
            left: 16,
            top: 16,
            right: 24,
            bottom: 16,
          ),
          decoration: this._getDecoration(context, imageUrl: this.coverPictureUrl),
        ),
        onTap: this.onTap,
      ),
    ));
  }

  Decoration _getDecoration(BuildContext context, {String imageUrl}) {
    ImageProvider<dynamic> backgroundImage = AssetImage('images/section-card-missing-cover.jpg');
    if (imageUrl != null) {
      backgroundImage = NetworkImage(imageUrl);
    }

    return BoxDecoration(
      image: DecorationImage(
        image: backgroundImage,
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Color.fromRGBO(66, 66, 66, 0.68), BlendMode.srcOver),
      ),
      color: Theme.of(context).textTheme.body1.color,
    );
  }
}
