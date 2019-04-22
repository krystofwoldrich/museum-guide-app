import '../actions/navigation.dart' as Actions;

int navigationReducer(int prevState, dynamic action) {
  if (action is Actions.ChangeTab) {
    return action.tabIndex;
  } else {
    return prevState;
  }
}