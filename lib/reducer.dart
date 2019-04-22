import './AppState.dart' show AppState;
import './reducers/ticketsReducer.dart' show ticketsReducer;
import './reducers/navigationReducer.dart' show navigationReducer;

AppState appReducer(AppState prevState, dynamic action) {
  return AppState(
    currentBottomTabIndex: navigationReducer(prevState.currentBottomTabIndex, action),
    tickets: ticketsReducer(prevState.tickets, action),
  );
}

