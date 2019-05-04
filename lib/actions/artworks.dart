import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/helpers/apiHostUrlLoader.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/Artwork.dart';

@immutable
class FetchArtworksRequest { }

@immutable
class FetchArtworksResponseSuccess {
  final List<Artwork> artworks;

  FetchArtworksResponseSuccess(List<Artwork> artworks)
    : this.artworks = List.unmodifiable(artworks);
}

@immutable
class FetchArtworksResponseError { }

ThunkAction<AppState> getArtworkBySection(int sectionId) {
  return (Store<AppState> store) async {
    store.dispatch(FetchArtworksRequest());
    final api = await loadApiHostUrl();

    try {
      Response response = await post(
          api,
          body: { 'query': '{artworks(where: {section: {id: $sectionId}}){id, title, description, made}}' }
      );

      List artworks = json.decode(response.body)['data']['artworks'];

      store.dispatch(FetchArtworksResponseSuccess(
          artworks.map((artwork) => Artwork(
            id: artwork['id'],
            title: artwork['title'],
            description: artwork['description'],
            made: DateTime.parse(artwork['description']),
          )).toList()
      ));
    } catch (e) {
      //TODO: sentry error log
      store.dispatch(FetchArtworksResponseError());
    }
  };
}


ThunkAction<AppState> getArtworks = (Store<AppState> store) async {
  store.dispatch(FetchArtworksRequest());
  final api = await loadApiHostUrl();

  try {
    Response response = await post(
      api,
      body: { 'query': '{artworks{id, title, description}}' }
    );

    List artworks = json.decode(response.body)['data']['artworks'];

    store.dispatch(FetchArtworksResponseSuccess(
        artworks.map((artwork) => Artwork(
          id: artwork['id'],
          title: artwork['title'],
          description: artwork['description'],
          made: DateTime.parse(artwork['description']),
        )).toList()
    ));
  } catch (e) {
    //TODO: sentry error log
    store.dispatch(FetchArtworksResponseError());
  }
};