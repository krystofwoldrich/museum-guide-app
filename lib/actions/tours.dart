import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/helpers/apiHostUrlLoader.dart';
import 'package:museum_guide_app/model/Location.dart';
import 'package:museum_guide_app/model/Room.dart';
import 'package:museum_guide_app/model/Step.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/Tour.dart';

@immutable
class FetchToursRequest {}

@immutable
class FetchToursResponseSuccess {
  final List<Tour> tours;

  FetchToursResponseSuccess(List<Tour> tours)
      : this.tours = List.unmodifiable(tours);
}

@immutable
class FetchToursResponseError {}

ThunkAction<AppState> getToursByExhibition(int exhibitionId) {
  return (Store<AppState> store) async {
    store.dispatch(FetchToursRequest());
    final api = await loadApiHostUrl();

    try {
      Response response = await post(api, body: {
        'query':
            '{tours(where: {exhibition: {id: $exhibitionId}}){id, name, description, coverPicture{sourceFile{url}}, steps{id, index, title, description}}}'
      });

      List tours = json.decode(response.body)['data']['tours'];

      store.dispatch(FetchToursResponseSuccess(tours
          .map((tour) => Tour(
                id: tour['id'],
                name: tour['name'],
                description: tour['description'],
                coverPictureUrl: tour['coverPicture'] == null ? null : tour['coverPicture']['sourceFile']['url'],
                steps: List<Step>.from((tour['steps'])
                    .map((step) => Step(
                          id: step['id'],
                          index: step['index'],
                          title: step['title'],
                          description: step['description'],
                        ))
                    .toList()),
              ))
          .toList()));
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
    Response response =
        await post(api, body: {'query': '{tours{id, name, description, coverPicture{sourceFile{url}}}}'});

    List tours = json.decode(response.body)['data']['tours'];

    store.dispatch(FetchToursResponseSuccess(tours
        .map((tour) => Tour(
              id: tour['id'],
              name: tour['name'],
              description: tour['description'],
              coverPictureUrl: tour['coverPicture'] == null ? null : tour['coverPicture']['sourceFile']['url'],
            ))
        .toList()));
  } catch (e) {
    //TODO: sentry error log
    store.dispatch(FetchToursResponseError());
  }
};

ThunkAction<AppState> getTourDetail(String tourId) {
  return (Store<AppState> store) async {
    store.dispatch(FetchToursRequest());
    final api = await loadApiHostUrl();

    try {
      Response response = await post(api, body: {
        'query':
            '{tours(where: {id: $tourId}){id, name, description, steps{id,title, description, index, coverPicture{url}, location{id, name, room{id, name, number}}}}}'
      });

      List tours = json.decode(response.body)['data']['tours'];

      store.dispatch(FetchToursResponseSuccess(tours
          .map((tour) => Tour(
                id: tour['id'],
                name: tour['name'],
                description: tour['description'],
                steps: List<Step>.from((tour['steps'])
                    .map((step) => Step(
                        id: step['id'],
                        index: step['index'],
                        title: step['title'],
                        description: step['description'],
                        coverPictureUrl: step['coverPicture']['url'],
                        location: Location(
                            id: step['location']['id'],
                            name: step['location']['name'],
                            room: Room(
                              id: step['location']['room']['id'],
                              name: step['location']['room']['name'],
                              number: step['location']['room']['number'],
                            ))))
                    .toList()),
              ))
          .toList()));
    } catch (e) {
      //TODO: sentry error log
      print(e.toString());
      store.dispatch(FetchToursResponseError());
    }
  };
}
