import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/helpers/apiHostUrlLoader.dart';
import 'package:museum_guide_app/model/Section.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/Exhibition.dart';

@immutable
class FetchExhibitionsRequest { }

@immutable
class FetchExhibitionsResponseSuccess {
  final List<Exhibition> exhibitions;

  FetchExhibitionsResponseSuccess(List<Exhibition> exhibitions)
    : this.exhibitions = List.unmodifiable(exhibitions);
}

@immutable
class FetchExhibitionsResponseError { }

ThunkAction<AppState> getPastExhibitions = (Store<AppState> store) async {
  store.dispatch(FetchExhibitionsRequest());
  final api = await loadApiHostUrl();
  final date =  DateTime.now().toString();

  try {
    Response response = await post(
        api,
        body: { 'query': '{exhibitions(where: {to_lte: $date}){id, title, description, from, to}}' }
    );

    List exhibitions = json.decode(response.body)['data']['exhibitions'];

    store.dispatch(FetchExhibitionsResponseSuccess(
        exhibitions.map((exhibition) => Exhibition(
        id: exhibition['id'],
        title: exhibition['title'],
        description: exhibition['description'],
        from: DateTime.parse(exhibition['from']),
        to: DateTime.parse(exhibition['to']),
      )).toList()
    ));
  } catch (e) {
    //TODO: sentry error log
    store.dispatch(FetchExhibitionsResponseError());
  }
};

ThunkAction<AppState> getActualExhibitions = (Store<AppState> store) async {
  store.dispatch(FetchExhibitionsRequest());
  final api = await loadApiHostUrl();
  final date =  DateTime.now().toString();

  try {
    Response response = await post(
        api,
        body: { 'query': '{exhibitions(where: {from_lte: \"$date\", to_gte: \"$date\"}){id, title, description, from, to}}' }
    );

    List exhibitions = json.decode(response.body)['data']['exhibitions'];

    store.dispatch(FetchExhibitionsResponseSuccess(
        exhibitions.map((exhibition) => Exhibition(
          id: exhibition['id'],
          title: exhibition['title'],
          description: exhibition['description'],
          from: DateTime.parse(exhibition['from']),
          to: DateTime.parse(exhibition['to']),
        )).toList()
    ));
  } catch (e) {
    //TODO: sentry error log
    store.dispatch(FetchExhibitionsResponseError());
  }
};

ThunkAction<AppState> getFutureExhibitions = (Store<AppState> store) async {
  store.dispatch(FetchExhibitionsRequest());
  final api = await loadApiHostUrl();
  final date =  DateTime.now().toString();

  try {
    Response response = await post(
        api,
        body: { 'query': '{exhibitions(where: {from_gte: $date}){id, title, description, from, to}}' }
    );

    List exhibitions = json.decode(response.body)['data']['exhibitions'];

    store.dispatch(FetchExhibitionsResponseSuccess(
        exhibitions.map((exhibition) => Exhibition(
          id: exhibition['id'],
          title: exhibition['title'],
          description: exhibition['description'],
          from: DateTime.parse(exhibition['from']),
          to: DateTime.parse(exhibition['to']),
        )).toList()
    ));
  } catch (e) {
    //TODO: sentry error log
    store.dispatch(FetchExhibitionsResponseError());
  }
};

ThunkAction<AppState> getExhibitionDetail(int exhibitionId) {
  return (Store<AppState> store) async {
    store.dispatch(FetchExhibitionsRequest());
    final api = await loadApiHostUrl();

    try {
      Response response = await post(
          api,
          body: { 'query': '{exhibitions(where: {id: $exhibitionId}){id, title, description, from, to, sections{id, name}}}' }
      );

      List exhibitions = json.decode(response.body)['data']['exhibitions'];

      store.dispatch(FetchExhibitionsResponseSuccess(
          exhibitions.map((exhibition) => Exhibition(
            id: exhibition['id'],
            title: exhibition['title'],
            description: exhibition['description'],
            from: DateTime.parse(exhibition['from']),
            to: DateTime.parse(exhibition['to']),
            sections: List<Section>.from((exhibition['sections']).map((section) => Section(
                id: section['id'],
                name: section['name']
            )).toList()),
          )).toList()
      ));
    } catch (e) {
      //TODO: sentry error log
      store.dispatch(FetchExhibitionsResponseError());
    }
  };
}
