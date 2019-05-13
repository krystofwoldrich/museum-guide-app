import 'package:flutter/material.dart';
import 'package:museum_guide_app/screens/ExhibitionDetail.dart';

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
        child: Text(
          this.description,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
        ),
        margin: EdgeInsets.only(top: 16),
      ));
    }

    return this._withCustomTheme(context, Container(
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
            decoration: this._getDecoration(context, imageUrl: this.coverPictureUrl),
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

  Widget _withCustomTheme(BuildContext context, Widget widget) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      child: widget,
    );  
  }

  Decoration _getDecoration(BuildContext context, {String imageUrl}) {
    ImageProvider<dynamic> backgroundImage = AssetImage('images/exhibition-card-missing-cover.jpg');
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