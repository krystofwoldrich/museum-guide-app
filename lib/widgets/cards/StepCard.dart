import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final void Function() onTap;

  StepCard({
    @required this.id,
    @required this.title,
    @required this.description,
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

    return Container(
      width: 200,
      child: Card(
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: content,
          ),
          onTap: this.onTap
        ),
      ),
    );
  }
}