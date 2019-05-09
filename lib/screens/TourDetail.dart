import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/actions/tours.dart';
import 'package:museum_guide_app/model/Tour.dart';
import 'package:museum_guide_app/model/Step.dart' as StepModel;
import 'package:museum_guide_app/screens/StepDetail.dart';
import 'package:museum_guide_app/widgets/Section.dart';
import 'package:museum_guide_app/widgets/cards/StepCard.dart';

class TourDetail extends StatelessWidget {
  final String tourId;

  TourDetail({@required this.tourId});

  @override
  Widget build(BuildContext context) {
    //TODO: Add check if tour is already fully downloaded
    StoreProvider.of<AppState>(context).dispatch(getTourDetail(this.tourId));

    return StoreConnector<AppState, Tour>(
      converter: (store) {
        final tours = store.state.tours;
        final toursMap =
            tours.asMap().map((_, tour) => MapEntry(tour.id, tour));
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
        Text(tour.description != null
            ? tour.description
            : 'No description available.'),
      ],
    ));

    if (tour.steps != null) {
      content.add(Section(
          title: 'Steps',
          content: tour.steps.map((StepModel.Step step) {
            return StepCard(
              id: step.id,
              title: step.title,
              description: "",
            );
          }).toList(),
          onMoreTitle: "Start tour",
          onMore: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PageView.builder(
                      controller: new PageController(),
                      itemBuilder: (BuildContext context, int index) {
                        print("Index: " + index.toString());
                        return StepDetail(
                            actualStepIndex: index, steps: tour.steps);
                      },
                      itemCount: tour.steps.length,
                    )));
          }));
    }

    return ListView(
      children: content,
    );
  }
}
