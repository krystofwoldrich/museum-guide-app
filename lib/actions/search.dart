import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/helpers/SearchResultType.dart';
import 'package:museum_guide_app/helpers/apiHostUrlLoader.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/SearchResult.dart';

@immutable
class FetchSearchRequest { }

@immutable
class FetchSearchResponseSuccess {
  final List<SearchResult> search;

  FetchSearchResponseSuccess(List<SearchResult> search)
      : this.search = List.unmodifiable(search);
}

@immutable
class FetchSearchResponseError { }

ThunkAction<AppState> getSearchResults(String searchedTerm) {
  return (Store<AppState> store) async {
    store.dispatch(FetchSearchRequest());
    final api = await loadApiHostUrl();

    try {
      Response response = await post(
          api,
          body: { 'query': '{exhibition(where: {description_contains: \"$searchedTerm\"}){id, title, description}}' }
      );

      List search = json.decode(response.body)['data']['search'];
      //TODO load data from other entities

      store.dispatch(FetchSearchResponseSuccess(
          search.map((section) => SearchResult(
            id: section['id'],
            title: section['title'],
            description: section['description'],
            searchResultType: SearchResultType.Exhibition
          )).toList()
      ));
    } catch (e) {
      //TODO: sentry error log
      store.dispatch(FetchSearchResponseError());
    }
  };
}
