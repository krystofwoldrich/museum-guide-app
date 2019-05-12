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
    return Center(
      child: Card(
        child: Container(
          child: Column(
            children: <Widget>[
                Text(
                  this.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                ),
                Container(
                  child: Text(
                    '€' + this.price.toString() + ' per person',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
                  ),
                  margin: EdgeInsets.only(top: 8),
                ),
            ],
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
        ),
      ),
    );
  }
}