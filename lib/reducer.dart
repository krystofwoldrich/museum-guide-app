import './AppState.dart' show AppState;
import './reducers/ticketsReducer.dart' show ticketsReducer;
import './reducers/navigationReducer.dart' show navigationReducer;
import './reducers/exhibitonsReducer.dart' show exhibitionsReducer;

AppState appReducer(AppState prevState, dynamic action) {
  return AppState(
    currentBottomTabIndex: navigationReducer(prevState.currentBottomTabIndex, action),
    tickets: ticketsReducer(prevState.tickets, action),
    exhibitions: exhibitionsReducer(prevState.exhibitions, action),
  );
}

