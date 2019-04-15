import 'package:flutter/material.dart';
import '../layouts/LayoutWithAppBarWithBottomNavigation.dart';

class Dashboard extends StatelessWidget {
  final String _title = 'Welcome';

  @override
  Widget build(BuildContext context) {    
    return LayoutWithAppBarWithBottomNavigation(
      child: this._getContent(), 
      title: this._getTextTitle(), 
      leading: null
    );
  }

  Widget _getContent() {
    return null;
  }

  Text _getTextTitle() {
    return Text(this._title);
  }
}
