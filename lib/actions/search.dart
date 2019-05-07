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
class FetchSearchRequest {
  final String query;

  FetchSearchRequest({@required this.query});
}

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
    store.dispatch(FetchSearchRequest(query: searchedTerm));
    final api = await loadApiHostUrl();

    const List<Map<String, String>> searchCategories = [
      {
        'category'  : 'exhibitions',
        'field'     : 'description_contains',
      },
      {
        'category'  : 'exhibitions',
        'field'     : 'title_contains',
      },
      {
        'category'  : 'artworks',
        'field'     : 'title_contains',
      },
    ];

    try {
      final List<Future<Response>> searchResultsFutures = searchCategories.map((Map<String, String> searchCategory) {
        return post(
          api,
          body: { 'query': """{
            ${searchCategory['category']}(where: {
                ${searchCategory['field']}: \"$searchedTerm\"
              }){
              id, 
              title, 
              description
            }}""" }
        );
      }).toList();

      final List<Response> searchResponses = await Future.wait(searchResultsFutures);

      final List searchLists = searchResponses.asMap().map((int index, Response response) {
        return MapEntry(index, json.decode(response.body)['data'][searchCategories[index]['category']]);
      }).values.toList();

      final Map<String, SearchResult> search = Map();
      searchLists.asMap().forEach((int categoryIndex, results) {
        (results as List).forEach((result) {
          search.putIfAbsent(
            searchCategories[categoryIndex]['category'] + result['id'], 
            () => SearchResult(
              id: result['id'],
              title: result['title'],
              description: result['description'],
              searchResultType: _getSearchResultTypeByCategory(searchCategories[categoryIndex]['category']),
            )
          );
        });
      });

      store.dispatch(FetchSearchResponseSuccess(search.values.toList()));
    } catch (e) {
      //TODO: sentry error log
      print(e);
      store.dispatch(FetchSearchResponseError());
    }
  };
}

SearchResultType _getSearchResultTypeByCategory(String category) {
  switch (category) {
    case 'exhibitions':
      return SearchResultType.Exhibition;  
    case 'artworks':
      return SearchResultType.Artwork;
    default:
     throw Exception('Unknown category');
  }
}