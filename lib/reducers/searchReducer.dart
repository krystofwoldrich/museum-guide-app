import 'package:museum_guide_app/AppState.dart';

import '../actions/search.dart' as Actions;

SearchState searchReducer(SearchState prevState, dynamic action) {
  if (action is Actions.FetchSearchRequest) {
    List<String> newHistory = List.from(prevState.history);
    newHistory.add(action.query);

    return SearchState(
      loading: true,
      history: newHistory,
      results: [],
    );
  } else if (action is Actions.FetchSearchResponseSuccess) {
    return SearchState(
      loading: false,
      history: prevState.history,
      results: action.search,
    );
  } else if (action is Actions.FetchSearchResponseError) {
    return SearchState(
      loading: false,
      history: prevState.history,
      results: [],
    );
  } else {
    return prevState;
  }
}