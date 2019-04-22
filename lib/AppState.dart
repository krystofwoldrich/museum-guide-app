import 'package:meta/meta.dart';
import './model/Ticket.dart';

@immutable
class AppState {
  final int currentBottomTabIndex;
  final List<Ticket> tickets;

  AppState({
    @required this.currentBottomTabIndex,
    @required List<Ticket> tickets
  }) :
    this.tickets = List.unmodifiable(tickets);
}

final initialState = new AppState(
  currentBottomTabIndex: 0,
  tickets: []
);
