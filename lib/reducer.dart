import './AppState.dart' show AppState;
import './reducers/ticketsReducer.dart' show ticketsReducer;
import './reducers/navigationReducer.dart' show navigationReducer;
import './reducers/exhibitonsReducer.dart' show exhibitionsReducer, exhibitionDetailReducer;
import './reducers/searchReducer.dart' show searchReducer;
import './reducers/toursReducer.dart' show toursReducer;
import './reducers/sectionsReducer.dart' show sectionDetailReducer;

AppState appReducer(AppState prevState, dynamic action) {
  return AppState(
    currentBottomTabIndex: navigationReducer(prevState.currentBottomTabIndex, action),
    tickets: ticketsReducer(prevState.tickets, action),
    exhibitions: exhibitionsReducer(prevState.exhibitions, action),
    exhibitionDetail: exhibitionDetailReducer(prevState.exhibitionDetail, action),
    sectionDetail: sectionDetailReducer(prevState.sectionDetail, action),
    tours: toursReducer(prevState.tours, action),
    search: searchReducer(prevState.search, action),
  );
}

