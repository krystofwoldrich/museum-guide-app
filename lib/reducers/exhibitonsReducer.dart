import '../model/Exhibition.dart';
import '../actions/exhibitions.dart' as Actions;

List<Exhibition> exhibitionsReducer(List<Exhibition> prevState, dynamic action) {
  if (action is Actions.FetchExhibitionsRequest) {
    return prevState;
  } if (action is Actions.FetchExhibitionsResponseSuccess) {
    return action.exhibitions;
  } if (action is Actions.FetchExhibitionsResponseError) {
    return prevState;
  } else {
    return prevState;
  }
}