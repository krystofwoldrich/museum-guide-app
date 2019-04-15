import './AppState.dart' show AppState;
import './actions.dart' as Actions;

AppState appReducer(AppState prevState, dynamic action) {
  if (action is Actions.DummyAction) {
    return new AppState();
  } else {
    return prevState;
  }
}
