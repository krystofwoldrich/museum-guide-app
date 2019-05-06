import 'package:meta/meta.dart';
import './model/Ticket.dart';
import './model/Exhibition.dart';

@immutable
class AppState {
  final int currentBottomTabIndex;
  final List<Ticket> tickets;
  final List<Exhibition> exhibitions;

  AppState({
    @required this.currentBottomTabIndex,
    @required List<Ticket> tickets,
    @required List<Exhibition> exhibitions
  }) :
    this.tickets = List.unmodifiable(tickets),
    this.exhibitions = List.unmodifiable(exhibitions);
}

final initialState = new AppState(
  currentBottomTabIndex: 0,
  tickets: [],
  exhibitions: []
);
