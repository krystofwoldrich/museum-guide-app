import '../model/Section.dart';
import '../actions/sections.dart' as SectionAction;
import '../actions/artworks.dart' as ArtworkAction;

List<Section> sectionsReducer(List<Section> prevState, dynamic action) {
  if (action is SectionAction.FetchSectionsRequest) {
    return prevState;
  } if (action is SectionAction.FetchSectionsResponseSuccess) {
    return action.sections;
  } if (action is SectionAction.FetchSectionsResponseError) {
    return prevState;
  } if (action is ArtworkAction.FetchArtworksBySectionResponseSuccess) {  
    final Map<String, Section> updatedSections = List<Section>
      .from(prevState)
      .asMap()
      .map((_, Section section) => MapEntry(section.id, section));

    updatedSections[action.sectionId] = updatedSections[action.sectionId].copyWith(
      artworks: action.artworks,
    );
    return updatedSections.values;
  } else {
    return prevState;
  }
}

Section sectionDetailReducer(Section prevState, dynamic action) {
  if (action is SectionAction.FetchSectionDetailResponseSuccess) {  
    return action.section;
  } else {
    return prevState;
  }
}
