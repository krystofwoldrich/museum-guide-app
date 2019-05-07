import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/characterStyles/ScreenTitle.dart';
import 'package:museum_guide_app/model/SearchResult.dart';
import 'package:museum_guide_app/widgets/cards/ExhibitionCard.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<SearchResult>>(
      converter: (store) => store.state.search.results,
      builder: (_, List<SearchResult> searchResults) {
        final List<Widget> content = [ScreenTitle('Results')];
        content.addAll(this._getResultsWidgets(searchResults));

        return Scaffold(
          appBar: AppBar(
            title: Text('Results'),
          ),
          body: ListView(
            children: content,
          ),
        );
      }, 
    );
  }

  List<Widget> _getResultsWidgets(List<SearchResult> searchResults) {
    return searchResults.map((SearchResult result) => ExhibitionCard(
      title: result.title,
      description: result.description,
    )).toList();
  }
}