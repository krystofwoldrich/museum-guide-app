import 'package:flutter/material.dart';

Widget createLoadingWidget(BuildContext context) {
  return new Center(
    child: new CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    ),
  );
}
