import 'package:meta/meta.dart';
import './model/Ticket.dart';

@immutable
class AppState {
  final List<Ticket> tickets;

  AppState({
    @required List<Ticket> tickets
  }) :
    this.tickets = List.unmodifiable(tickets);
}

final initialState = new AppState(
  tickets: [Ticket(
    name: 'trs',
    description: 'adda',
    price: 12.88,
  ),
  Ticket(
    name: 'trsss',
    description: 'adda',
    price: 12.88,
  )]
);
