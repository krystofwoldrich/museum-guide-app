import 'package:flutter/material.dart';
import 'package:museum_guide_app/model/Tour.dart';
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
          final exhibitionsMap = store.state.exhibitions.asMap().map((_, exhibition) => MapEntry(exhibition.id, exhibition));
          return exhibitionsMap[this.exhibitionId].tours;
        },
        builder: (_, List<Tour> tours) => ListView(
          children: tours.map((tour) => TourCard(
            id: tour.id,
            title: tour.name,
            description: tour.description,
            lengthInHours: tour.lengthInHours,
          )).toList(),
        ),
      ),
    );
  }
}
