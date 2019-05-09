import 'package:flutter/material.dart';
import 'package:museum_guide_app/helpers/ExhibitionState.dart';
import 'package:museum_guide_app/widgets/ExhibitionList.dart';

class ExhibitionTabs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return this._getContent();
  }

  Widget _getContent() {
     return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Current",),
                Tab(text: "Past",),
                Tab(text: "Future",),
              ],
            ),
            title: Text('Exhibitions'),
          ),
          body: TabBarView(
            children: [
              new ExhibitionList(exhibitionState: ExhibitionState.Current),
              new ExhibitionList(exhibitionState: ExhibitionState.Past),
              new ExhibitionList(exhibitionState: ExhibitionState.Future),
            ],
          ),
        ),
    );
  }
}
