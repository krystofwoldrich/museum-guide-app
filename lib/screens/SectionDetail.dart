import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/actions/sections.dart';
import 'package:museum_guide_app/model/Section.dart' as Model;
import 'package:museum_guide_app/screens/ArtworkDetail.dart';
import 'package:museum_guide_app/widgets/LoadingWidget.dart';
import 'package:museum_guide_app/widgets/Section.dart';
import 'package:museum_guide_app/widgets/cards/ArtworkCard.dart';


class SectionDetail extends StatelessWidget {
  final String sectionId;

  SectionDetail({@required this.sectionId});

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getSectionById(this.sectionId));

    return StoreConnector<AppState, Model.Section>(
      converter: (store) {
        return store.state.sectionDetail;
      },
      builder: (BuildContext context, Model.Section section) {
        if (section == null || section.id != sectionId) {
          return Scaffold(
            appBar: AppBar(),
            body: createLoadingWidget(context),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(section.name),
            ),
            body: this._getContent(context, section),
          );
        }
      },
    );
  }

  Widget _getContent(BuildContext context, Model.Section section) {
    final List<Widget> content = [];

    content.add(Section(
      title: 'Description',
      description: section.description,
    ));

    content.add(Section(
      title: 'Artworks',
      content: section.artworks.map((artwork) => ArtworkCard(
        id: artwork.id,
        title: artwork.title,
        coverPictureUrl: artwork.coverPictureUrl,
        onTap: () {
          if (artwork.coverPictureUrl == null) return;

          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ArtworkDetail(title: artwork.title, imageUrl: artwork.coverPictureUrl,),
          )); 
        },
      )).toList(),
    ));

    return ListView(
      children: content,
    );
  }
}