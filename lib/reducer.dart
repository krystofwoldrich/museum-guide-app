import './AppState.dart' show AppState;
import './reducers/ticketsReducer.dart' show ticketsReducer;
import './reducers/navigationReducer.dart' show navigationReducer;
import './reducers/exhibitonsReducer.dart' show exhibitionsReducer;
import './reducers/searchReducer.dart' show searchReducer;

AppState appReducer(AppState prevState, dynamic action) {
  return AppState(
    currentBottomTabIndex: navigationReducer(prevState.currentBottomTabIndex, action),
    tickets: ticketsReducer(prevState.tickets, action),
    exhibitions: exhibitionsReducer(prevState.exhibitions, action),
    search: searchReducer(prevState.search, action),
  );
}

