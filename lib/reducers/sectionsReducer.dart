import '../model/Section.dart';
import '../actions/sections.dart' as Actions;

List<Section> sectionsReducer(List<Section> prevState, dynamic action) {
  if (action is Actions.FetchSectionsRequest) {
    return prevState;
  } if (action is Actions.FetchSectionsResponseSuccess) {
    return action.sections;
  } if (action is Actions.FetchSectionsResponseError) {
    return prevState;
  } else {
    return prevState;
  }
}