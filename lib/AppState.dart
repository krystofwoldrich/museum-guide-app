import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/SearchResult.dart';
import './model/Tour.dart';
import './model/Ticket.dart';
import './model/Exhibition.dart';

@immutable
class AppState {
  final int currentBottomTabIndex;
  final List<Ticket> tickets;
  final List<Exhibition> exhibitions;
  final Exhibition exhibitionDetail;
  final List<Tour> tours;
  final SearchState search;

  AppState({
    @required this.currentBottomTabIndex,
    @required List<Ticket> tickets,
    @required List<Exhibition> exhibitions,
    @required this.exhibitionDetail,
    @required List<Tour> tours,
    @required this.search,
  }) :
    this.tickets = List.unmodifiable(tickets),
    this.exhibitions = List.unmodifiable(exhibitions),
    this.tours = List.unmodifiable(tours);
}

final initialState = new AppState(
  currentBottomTabIndex: 0,
  tickets: [],
  exhibitions: [],
  exhibitionDetail: null,
  tours: [],
  search: SearchState(
    loading: false,
    history: [],
    results: [],
  ),
);

@immutable
class SearchState {
  final bool loading;
  final List<String> history;
  final List<SearchResult> results;

  SearchState({
    @required this.loading,
    @required List<String> history,
    @required List<SearchResult> results,
  }) :
    this.history = List.unmodifiable(history),
    this.results = List.unmodifiable(results);
}