import 'package:flutter/material.dart';
import 'package:museum_guide_app/model/Exhibition.dart';
import 'package:museum_guide_app/widgets/cards/ExhibitionCard.dart';
import '../widgets/PageContentContainer.dart';
import '../widgets/Section.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../AppState.dart';
import '../actions/exhibitions.dart' show getActualExhibitions;

class ExhibitionList extends StatelessWidget {
  ExhibitionList({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getActualExhibitions);
    return this._getContent();
  }

  Widget _getContent() {
    final List<Widget> exhibitionListContent = [];

    exhibitionListContent.add(this._createSectionWithStore());

    return PageContentContainer(
      child: ListView(
        children: exhibitionListContent,
      ),
    );
  }

  Widget _createSectionWithStore() {
    return StoreConnector<AppState, List<Exhibition>>(
      converter: (store) => store.state.exhibitions,
      builder: (_, List<Exhibition> exhibitions) => Section(
        title: 'Exhibitions',
        content: exhibitions
          .map((Exhibition exhibition) => ExhibitionCard(
            id: exhibition.id,
            title: exhibition.title,
            description: exhibition.description,
            from: exhibition.from,
            to: exhibition.to
          ))
          .toList(),
        isRow: false,
      ),
    );
  }
}
