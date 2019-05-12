import 'package:flutter/material.dart';
import 'package:museum_guide_app/helpers/ExhibitionState.dart';
import 'package:museum_guide_app/widgets/ExhibitionList.dart';

class ExhibitionTabs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return this._getContent(context);
  }

  Widget _getContent(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Exhibitions'),
      bottom: TabBar(
        tabs: [
          Tab(text: "Current".toUpperCase(),),
          Tab(text: "Past".toUpperCase(),),
          Tab(text: "Future".toUpperCase(),),
        ],
        indicatorColor: Theme.of(context).primaryColor,
        indicatorWeight: 4,
      ),
      backgroundColor: Colors.transparent,
    );

    double appBarHeight = appBar.preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return DefaultTabController(
      length: 3,
      child: Stack(
        children: <Widget>[
          Align(
            child: Container(
              height: appBarHeight+statusBarHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/exhibitions-list-cover.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Color.fromRGBO(66, 66, 66, 0.68), BlendMode.srcOver),
                ),
              ),
            ),
            alignment: Alignment.topCenter,
          ),
          Scaffold(
            appBar: appBar,
            body: TabBarView(
              children: [
                new ExhibitionList(exhibitionState: ExhibitionState.Current),
                new ExhibitionList(exhibitionState: ExhibitionState.Past),
                new ExhibitionList(exhibitionState: ExhibitionState.Future),
              ],
            ),
            backgroundColor: Colors.transparent,
          ),
        ],
      )
  );
}
}
