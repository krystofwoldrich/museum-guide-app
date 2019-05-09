import 'package:flutter/material.dart';
import 'package:museum_guide_app/model/Tour.dart';
import 'package:museum_guide_app/screens/TourDetail.dart';
import 'package:museum_guide_app/widgets/cards/TourCard.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../AppState.dart';

class ToursList extends StatelessWidget {
  final String exhibitionId;

  ToursList({this.exhibitionId});

  @override
  Widget build(BuildContext context) {
    return this._getContent();
  }

  Widget _getContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tours'),
      ),
      body: StoreConnector<AppState, List<Tour>>(
        converter: (store) {
          return store.state.exhibitionDetail.tours;
        },
        builder: (BuildContext context, List<Tour> tours) => ListView(
          children: tours.map((tour) => TourCard(
            id: tour.id,
            title: tour.name,
            description: tour.description,
            lengthInHours: tour.lengthInHours,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => TourDetail(
                  tourId: tour.id,
                ),
              ));
            },
          )).toList(),
        ),
      ),
    );
  }
}
