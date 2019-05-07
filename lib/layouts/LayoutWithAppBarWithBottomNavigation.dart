import 'package:flutter/material.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/screens/Dashboard.dart';
import 'package:museum_guide_app/screens/search/Search.dart';
import 'package:redux/redux.dart';
import '../actions/navigation.dart' show ChangeTab;

class LayoutWithAppBarWithBottomNavigation extends StatelessWidget {
  LayoutWithAppBarWithBottomNavigation();

  @override
  Widget build(BuildContext context) {
    List<Widget> tabsWidgets = [
      Dashboard(key: PageStorageKey('dashboard')),
      null,
      null,
      Search(key: PageStorageKey('search')),
    ];

    return StoreConnector(
      converter: (Store<AppState> store) => store.state.currentBottomTabIndex,
      builder: (BuildContext context, int currentTabIndex) => Scaffold(
        appBar: this._getAppBar(),
        bottomNavigationBar: this._getBottomNavigationBar(context, currentTabIndex),
        body: tabsWidgets[currentTabIndex],
      ),
    );
  }

  PreferredSizeWidget _getAppBar() {
    return AppBar(
      title: Text('Welcome'),
    );
  }

  Widget _getBottomNavigationBar(BuildContext context, int currentTabIndex) {
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
      currentIndex: currentTabIndex,
      onTap: (int tappedIndex) => StoreProvider
        .of<AppState>(context)
        .dispatch(ChangeTab(tappedIndex)),
    );
  }
}
