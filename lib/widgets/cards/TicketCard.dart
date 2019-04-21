import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final String name;
  final double price;

  TicketCard({
    @required this.name,
    @required this.price,
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
                this.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
              ),
              Text(
                this.price.toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
              ),
          ],
        ),
      ),
    );
  }
}