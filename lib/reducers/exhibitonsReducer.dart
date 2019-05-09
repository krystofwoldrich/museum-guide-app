import '../model/Exhibition.dart';
import '../actions/exhibitions.dart' as Actions;

List<Exhibition> exhibitionsReducer(
    List<Exhibition> prevState, dynamic action) {
  if (action is Actions.FetchExhibitionsRequest) {
    return prevState;
  } else if (action is Actions.FetchExhibitionsResponseSuccess) {
    return action.exhibitions;
  } else if (action is Actions.FetchExhibitionsResponseError) {
    return prevState;
  } else {
    return prevState;
  }
}

Exhibition exhibitionDetailReducer(Exhibition prevState, dynamic action) {
  if (action is Actions.FetchExhibitionDetailRequest) {
    return prevState;
  } else if (action is Actions.FetchExhibitionDetailResponseSuccess) {
    return action.exhibition;
  } else if (action is Actions.FetchExhibitionDetailResponseError) {
    return prevState;
  } else {
    return prevState;
  }
}
