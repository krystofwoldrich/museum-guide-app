import './AppState.dart' show AppState;
import './reducers/ticketsReducer.dart' show ticketsReducer;

AppState appReducer(AppState prevState, dynamic action) {
  return AppState(
    tickets: ticketsReducer(prevState.tickets, action),
  );
}

