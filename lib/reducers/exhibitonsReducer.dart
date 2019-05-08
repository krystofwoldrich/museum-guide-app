import '../model/Exhibition.dart';
import '../actions/exhibitions.dart' as Actions;

List<Exhibition> exhibitionsReducer(List<Exhibition> prevState, dynamic action) {
  if (action is Actions.FetchExhibitionsRequest) {
    return prevState;
  } else if (action is Actions.FetchExhibitionsResponseSuccess) {
    return action.exhibitions;
  } else if (action is Actions.FetchExhibitionsResponseError) {
    return prevState;
  } else if (action is Actions.FetchExhibitionDetailRequest) {
    return prevState;
  } else if (action is Actions.FetchExhibitionDetailResponseSuccess) {
    final exhibitionsMap = prevState.asMap().map((_, exhibition) => MapEntry(exhibition.id, exhibition));
    exhibitionsMap[action.exhibition.id] = action.exhibition;
    
    return exhibitionsMap.values.toList();
  } else if (action is Actions.FetchExhibitionDetailResponseError) {
    return prevState;
  } else {
    return prevState;
  }
}