import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/actions/exhibitions.dart';
import 'package:museum_guide_app/model/Exhibition.dart';
import 'package:museum_guide_app/model/Section.dart' as SectionModel;
import 'package:museum_guide_app/model/Tour.dart';
import 'package:museum_guide_app/screens/SectionList.dart';
import 'package:museum_guide_app/screens/TourDetail.dart';
import 'package:museum_guide_app/screens/ToursList.dart';
import 'package:museum_guide_app/widgets/LoadingWidget.dart';
import 'package:museum_guide_app/widgets/Section.dart';
import 'package:museum_guide_app/widgets/cards/SectionCard.dart';
import 'package:museum_guide_app/widgets/cards/TourCard.dart';

class ExhibitionDetail extends StatelessWidget {
  final String exhibitionId;

  ExhibitionDetail({@required this.exhibitionId});

  @override
  Widget build(BuildContext context) {
    //TODO: Add check if exhibition is already fully downloaded
    StoreProvider.of<AppState>(context).dispatch(getExhibitionDetail(this.exhibitionId));

    return StoreConnector<AppState, Exhibition>(
      converter: (store) {
        return store.state.exhibitionDetail;
      },
      builder: (BuildContext context, Exhibition exhibition) {
        if (exhibition == null || exhibition.id != exhibitionId) {
          return Scaffold(
            appBar: AppBar(),
            body: createLoadingWidget(context),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(exhibition.title),
            ),
            body: this._getContent(context, exhibition),
          );
        }
      },
    );
  }

  Widget _getContent(BuildContext context, Exhibition exhibition) {
    final List<Widget> content = [];

    content.add(Section(
      title: 'Open',
      content: <Widget>[
        Text(
          DateFormat('MMM d, yyyy', 'en_US').format(exhibition.from) +
          '-' +
          DateFormat('MMM d, yyyy', 'en_US').format(exhibition.to)
        ),
      ],
    ));

    content.add(Section(
      title: 'Description',
      content: <Widget>[
        Text(exhibition.description != null ? exhibition.description : 'No description available.'),
      ],
    ));

    if (exhibition.sections != null) {
      content.add(Section(
        title: 'Artworks',
        content: exhibition.sections.map((SectionModel.Section section) {
          return SectionCard(
            id: section.id,
            title: section.name,
            description: "",
            piecesCount: 0,
            // onTap: () {},
          );
        }).toList(),
        isRow: true,
        onMore: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SectionList(exhibitionId: exhibition.id),
          ));
        },
      ));
    }

    if (exhibition.tours != null) {
      content.add(Section(
        title: 'Tours',
        content: exhibition.tours.map((Tour tour) {
          return TourCard(
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
          );
        }).toList(),
        isRow: true,
        onMore: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ToursList(exhibitionId: exhibition.id,),
          ));
        },
      ));
    }

    return ListView(
      children: content,
    );
  }
}