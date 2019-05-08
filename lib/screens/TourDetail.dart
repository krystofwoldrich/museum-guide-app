import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/actions/exhibitions.dart';
import 'package:museum_guide_app/model/Tour.dart';
import 'package:museum_guide_app/widgets/Section.dart';

class TourDetail extends StatelessWidget {
  final String exhibitionId;
  final String tourId;

  TourDetail({
    @required this.exhibitionId,
    @required this.tourId,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Add check if tour is already fully downloaded
    StoreProvider.of<AppState>(context).dispatch(getExhibitionDetail(this.tourId));

    return StoreConnector<AppState, Tour>(
      converter: (store) {
        final exhibitions = store.state.exhibitions;
        final exhibitionsMap = exhibitions.asMap().map((_, exhibition) => MapEntry(exhibition.id, exhibition));
        final toursMap = exhibitionsMap[this.exhibitionId].tours.asMap().map((_, tour) => MapEntry(tour.id, tour));

        return toursMap[this.tourId];
      },
      builder: (BuildContext context, Tour tour) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tour.name),
          ),
          body: this._getContent(context, tour),
        );
      },
    );
  }

  Widget _getContent(BuildContext context, Tour tour) {
    final List<Widget> content = [];

    content.add(Section(
      title: 'Description',
      content: <Widget>[
        Text(tour.description != null ? tour.description : 'No description available.'),
      ],
    ));

    return ListView(
      children: content,
    );
  }
}