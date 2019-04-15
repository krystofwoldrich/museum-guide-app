import 'package:flutter/material.dart';

class LayoutWithAppBarWithBottomNavigation extends StatelessWidget {
  final Text title;
  final Widget child;
  final IconButton leading;

  LayoutWithAppBarWithBottomNavigation(
    {this.child, 
    this.title,
    this.leading}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._getAppBar(),
      bottomNavigationBar: this._getBottomNavigationBar(),
      body: this.child,
    );
  }

  PreferredSizeWidget _getAppBar() {
    return AppBar(
      title: this.title,
      leading: this.leading,
    );
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Dashboard')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Tickets')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          title: Text('Map')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search')
        )
      ],
    );
  }
}
