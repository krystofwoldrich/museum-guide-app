import 'package:flutter/material.dart';
import 'package:museum_guide_app/widgets/cards/localCardTheme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SectionCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String coverPictureUrl;
  final int piecesCount;
  final void Function() onTap;

  SectionCard({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.piecesCount,
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
              ),
              Container(
                child: AutoSizeText(
                  this.description,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  minFontSize: 14,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(
                  bottom: 8,
                ),
              ),
              Container(
                child: Align(
                  child: Container(
                    child: Text(
                      this._getCountLabel(this.piecesCount),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).canvasColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                margin: EdgeInsets.only(
                  top: 8,
                ),
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

  String _getCountLabel(int count) {
    String afterCountLabel = count <= 1 ? 'piece' : 'pieces';
    String countText = count <= 0 ? '.' : count.toString(); 
    return '$countText $afterCountLabel';
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
