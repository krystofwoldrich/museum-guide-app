import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/helpers/apiHostUrlLoader.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/Tour.dart';

@immutable
class FetchToursRequest { }

@immutable
class FetchToursResponseSuccess {
  final List<Tour> tours;

  FetchToursResponseSuccess(List<Tour> tours)
    : this.tours = List.unmodifiable(tours);
}

@immutable
class FetchToursResponseError { }

ThunkAction<AppState> getTourByExhibition(int exhibitionId) {
  return (Store<AppState> store) async {
    store.dispatch(FetchToursRequest());
    final api = await loadApiHostUrl();

    try {
      Response response = await post(
          api,
          body: { 'query': '{tours(where: {exhibition: {id: $exhibitionId}}){id, name, description}}' }
      );

      List tours = json.decode(response.body)['data']['tours'];

      store.dispatch(FetchToursResponseSuccess(
          tours.map((tour) => Tour(
            id: tour['id'],
            name: tour['name'],
            description: tour['description'],
          )).toList()
      ));
    } catch (e) {
      //TODO: sentry error log
      store.dispatch(FetchToursResponseError());
    }
  };
}


ThunkAction<AppState> getTours = (Store<AppState> store) async {
  store.dispatch(FetchToursRequest());
  final api = await loadApiHostUrl();

  try {
    Response response = await post(
      api,
      body: { 'query': '{tours{id, title, description}}' }
    );

    List tours = json.decode(response.body)['data']['tours'];

    store.dispatch(FetchToursResponseSuccess(
        tours.map((tour) => Tour(
        id: tour['id'],
        name: tour['name'],
        description: tour['description'],
      )).toList()
    ));
  } catch (e) {
    //TODO: sentry error log
    store.dispatch(FetchToursResponseError());
  }
};