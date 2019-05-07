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
    final List<Widget> content = [
      Text(
        this.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
      ),
    ];

    if (this.description != null) {
      content.add(Text(
        this.description,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
      ));
    }

    return Container(
      width: 200,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: content,
        ),
      ),
    );
  }
}