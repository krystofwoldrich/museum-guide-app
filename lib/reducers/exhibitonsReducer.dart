import 'package:museum_guide_app/model/Section.dart';

import '../model/Exhibition.dart';
import '../actions/exhibitions.dart' as Actions;
import '../actions/artworks.dart' as ArtworkAction;


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
  } if (action is ArtworkAction.FetchArtworksBySectionResponseSuccess) {  
    final Map<String, Section> updatedSections = List<Section>
      .from(prevState.sections)
      .asMap()
      .map((_, Section section) => MapEntry(section.id, section));

    updatedSections[action.sectionId] = updatedSections[action.sectionId].copyWith(
      artworks: action.artworks,
    );


    return prevState.copyWith(
      sections: updatedSections.values.toList(),
    );
  } else {
    return prevState;
  }
}
