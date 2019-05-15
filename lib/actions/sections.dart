import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/helpers/apiHostUrlLoader.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/Section.dart';

@immutable
class FetchSectionsRequest { }

@immutable
class FetchSectionsResponseSuccess {
  final List<Section> sections;

  FetchSectionsResponseSuccess(List<Section> sections)
    : this.sections = List.unmodifiable(sections);
}

@immutable
class FetchSectionsResponseError { }

ThunkAction<AppState> getSectionByExhibition(int exhibitionId) {
  return (Store<AppState> store) async {
    store.dispatch(FetchSectionsRequest());
    final api = await loadApiHostUrl();

    try {
      Response response = await post(
          api,
          body: { 'query': '{sections(where: {exhibition: {id: $exhibitionId}}){id, name, description, coverPicture{sourceFile{url}}}}' }
      );

      List sections = json.decode(response.body)['data']['sections'];

      store.dispatch(FetchSectionsResponseSuccess(
          sections.map((section) => Section(
            id: section['id'],
            name: section['name'],
            description: section['description'],
            coverPictureUrl: section['coverPicture'] == null ? null : section['coverPicture']['sourceFile']['url'],
          )).toList()
      ));
    } catch (e) {
      //TODO: sentry error log
      store.dispatch(FetchSectionsResponseError());
    }
  };
}


ThunkAction<AppState> getSections = (Store<AppState> store) async {
  store.dispatch(FetchSectionsRequest());
  final api = await loadApiHostUrl();

  try {
    Response response = await post(
      api,
      body: { 'query': '{sections{id, name, description, coverPicture{sourceFile{url}}}}' }
    );

    List sections = json.decode(response.body)['data']['sections'];

    store.dispatch(FetchSectionsResponseSuccess(
        sections.map((section) => Section(
        id: section['id'],
        name: section['name'],
        description: section['description'],
        coverPictureUrl: section['coverPicture'] == null ? null : section['coverPicture']['sourceFile']['url'],
      )).toList()
    ));
  } catch (e) {
    //TODO: sentry error log
    store.dispatch(FetchSectionsResponseError());
  }
};