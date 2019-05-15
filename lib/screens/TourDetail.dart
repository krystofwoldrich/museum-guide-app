import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/actions/tours.dart';
import 'package:museum_guide_app/model/Tour.dart';
import 'package:museum_guide_app/model/Step.dart' as StepModel;
import 'package:museum_guide_app/screens/StepDetail.dart';
import 'package:museum_guide_app/widgets/LoadingWidget.dart';
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
        if (tour == null || tour.id != tourId) {
          return Scaffold(
            appBar: AppBar(),
            body: createLoadingWidget(context),
          );
        } else {
           return Scaffold(
            appBar: AppBar(
              title: Text(tour.name),
            ),
            body: this._getContent(context, tour),
          );
        }
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
          content: tour.steps.asMap().map((int stepIndex, StepModel.Step step) {
            return MapEntry(stepIndex, StepCard(
              id: step.id,
              title: step.title,
              description: step.description,
              coverPictureUrl: step.coverPictureUrl,
              multimedias: step.multimedias,
              onTap: () {
                this._openTour(context, tour, initPageIndex: stepIndex);
              },
            ));
          }).values.toList(),
          onMoreTitle: "Start tour",
          onMore: () {
            this._openTour(context, tour);
          }));
    }

    return ListView(
      children: content,
    );
  }

  void _openTour(BuildContext context, Tour tour, {int initPageIndex = 0}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PageView.builder(
        controller: new PageController(initialPage: initPageIndex),
        itemBuilder: (BuildContext context, int index) {
          return StepDetail(
            tourName: tour.name,
            step: tour.steps.firstWhere((step) => step.index == index),
            stepCount: tour.steps.length
          );
        },
        itemCount: tour.steps.length,
      )
    ));
  } 
}
