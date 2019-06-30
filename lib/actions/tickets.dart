import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/helpers/apiHostUrlLoader.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/Ticket.dart';

@immutable
class FetchTicketsRequest { }

@immutable
class FetchTicketsResponseSuccess {
  final List<Ticket> tickets;

  FetchTicketsResponseSuccess(List<Ticket> tickets)
    : this.tickets = List.unmodifiable(tickets);
}

@immutable
class FetchTicketsResponseError { }

ThunkAction<AppState> getTickets = (Store<AppState> store) async {
  store.dispatch(FetchTicketsRequest());
  final api = await loadApiHostUrl();

  try {
    Response response = await post(
      api,
      body: { 'query': '{tickets{id, name, price}}' }
    );

    List tickets = json.decode(response.body)['data']['tickets'];

    store.dispatch(FetchTicketsResponseSuccess(
      tickets.map((ticket) => Ticket(
        id: ticket['id'],
        name: ticket['name'],
        price: double.parse(ticket['price'].toString()),
      )).toList()
    ));
  } catch (e) {
    //TODO: sentry error log
    print(e);
    store.dispatch(FetchTicketsResponseError());
  }
};