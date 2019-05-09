import 'package:flutter/material.dart';
import 'package:museum_guide_app/actions/exhibitions.dart';
import 'package:museum_guide_app/helpers/ExhibitionState.dart';
import 'package:museum_guide_app/model/Exhibition.dart';
import 'package:museum_guide_app/widgets/cards/ExhibitionCard.dart';
import '../widgets/Section.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../AppState.dart';

class ExhibitionList extends StatelessWidget {
  final ExhibitionState exhibitionState;

  ExhibitionList({@required this.exhibitionState});

  @override
  Widget build(BuildContext context) {
    if (exhibitionState == ExhibitionState.Current) {
      StoreProvider.of<AppState>(context).dispatch(getActualExhibitions);
    } else if (exhibitionState == ExhibitionState.Past) {
      StoreProvider.of<AppState>(context).dispatch(getPastExhibitions);
    } else if (exhibitionState == ExhibitionState.Future) {
      StoreProvider.of<AppState>(context).dispatch(getFutureExhibitions);
    }

    return this._getContent();
  }

  Widget _getContent() {
    final List<Widget> exhibitionListContent = [];

    exhibitionListContent.add(this._createSectionWithStore());

    return Scaffold(
      body: ListView(
        children: exhibitionListContent,
      ),
    );
  }

  Widget _createSectionWithStore() {
    return StoreConnector<AppState, List<Exhibition>>(
      converter: (store) => store.state.exhibitions,
      builder: (_, List<Exhibition> exhibitions) => Section(
            content: exhibitions
                .map((Exhibition exhibition) => ExhibitionCard(
                    id: exhibition.id,
                    title: exhibition.title,
                    description: exhibition.description,
                    from: exhibition.from,
                    to: exhibition.to))
                .toList(),
            isRow: false,
          ),
    );
  }
}
