import 'package:flutter/material.dart';
import 'package:museum_guide_app/model/Section.dart';
import 'package:museum_guide_app/widgets/cards/SectionCard.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../AppState.dart';

class SectionList extends StatelessWidget {
  final String exhibitionId;

  SectionList({this.exhibitionId});

  @override
  Widget build(BuildContext context) {
    return this._getContent();
  }

  Widget _getContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sections'),
      ),
      body: StoreConnector<AppState, List<Section>>(
        converter: (store) {
          final exhibitionsMap = store.state.exhibitions.asMap().map((_, exhibition) => MapEntry(exhibition.id, exhibition));
          return exhibitionsMap[this.exhibitionId].sections;
        },
        builder: (BuildContext context, List<Section> sections) => ListView(
          children: sections.map((section) => SectionCard(
            id: section.id,
            title: section.name,
            description: section.description,
            piecesCount: sections.length,
           /* onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SectionDetail(
                  sectionId: section.id,
                ),
              ));
            },*/
          )).toList(),
        ),
      ),
    );
  }
}
