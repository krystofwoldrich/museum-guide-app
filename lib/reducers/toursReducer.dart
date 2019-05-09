import '../model/Tour.dart';
import '../actions/tours.dart' as Actions;

List<Tour> toursReducer(List<Tour> prevState, dynamic action) {
  if (action is Actions.FetchToursRequest) {
    return prevState;
  } if (action is Actions.FetchToursResponseSuccess) {
    return action.tours;
  } if (action is Actions.FetchToursResponseError) {
    return prevState;
  } else {
    return prevState;
  }
}