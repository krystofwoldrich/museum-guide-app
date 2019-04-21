import 'package:flutter/material.dart';

class PageContentContainer extends StatelessWidget {
  final Widget child;

  PageContentContainer({
    this.child
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.child,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
      ),
    );
  }
}