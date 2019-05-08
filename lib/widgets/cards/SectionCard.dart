import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final int piecesCount;
  final void Function() onTap;

  SectionCard({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.piecesCount,
    void Function() onTap,
  }) : this.onTap = onTap != null ? onTap : (() {}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        child: InkWell(
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
              Text(
                this.piecesCount.toString()
              ),
            ],
          ),
          onTap: this.onTap,
        ),
      ),
    );
  }
}
