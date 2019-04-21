import '../model/Ticket.dart';
import '../actions/tickets.dart' as Actions;

List<Ticket> ticketsReducer(List<Ticket> prevState, dynamic action) {
  if (action is Actions.FetchTicketsRequest) {
    return prevState;
  } if (action is Actions.FetchTicketsResponseSuccess) {
    return action.tickets;
  } if (action is Actions.FetchTicketsResponseError) {
    return prevState;
  } else {
    return prevState;
  }
}