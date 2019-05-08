import 'package:flutter/material.dart';

class TourCard extends StatelessWidget {
  static const double maxLengthInHours = 6; //hours
  final String id;
  final String title;
  final String description;
  final double lengthInHours;
  final void Function() onTap;

  TourCard({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.lengthInHours,
    void Function() onTap,
  }) : this.onTap = onTap != null ? onTap : (() {}) ;

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
      Text(
        this.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
      ),
    ];

    content.add(Text(
      this.description != null ? this.description : 'No description',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
    ));

    content.add(Text(
      this.lengthInHours != null ? this.lengthInHours.toString() : '3',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
    ));

    return Container(
      width: 200,
      child: Card(
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: content,
          ),
          onTap: this.onTap,
        ),
      ),
    );
  }
}