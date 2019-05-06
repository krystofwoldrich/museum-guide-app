import 'package:flutter/material.dart';

class ExhibitionCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;

  ExhibitionCard({
    @required this.title,
    @required this.description,
    this.from,
    this.to
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Text(
                this.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
              ),
              Text(
                this.description,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
              ),
          ],
        ),
      ),
    );
  }
}