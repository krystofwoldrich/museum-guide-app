import 'package:flutter/material.dart';
import '../widgets/PageContentContainer.dart';
import '../characterStyles/ScreenTitle.dart';
import '../widgets/Section.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../model/Ticket.dart';
import '../AppState.dart';
import '../actions/tickets.dart' show getTickets;
import '../widgets/cards/TicketCard.dart';

class Dashboard extends StatelessWidget {
  final String _title = 'Welcome';

  Dashboard({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getTickets);

    return this._getContent();
  }

  Widget _getContent() {
    final List<Widget> dashboardContent = [];

    dashboardContent.add(ScreenTitle(this._title));
    dashboardContent.add(this._createSectionWithStore());

    return PageContentContainer(
      child: ListView(
        children: dashboardContent,
      ),
    );
  }

  Widget _createSectionWithStore() {
    return StoreConnector<AppState, List<Ticket>>(
      converter: (store) => store.state.tickets,
      builder: (_, List<Ticket> tickets) => Section(
        title: 'Tickets',
        content: tickets
          .map((Ticket ticket) => TicketCard(
            name: ticket.name,
            price: ticket.price,
          ))
          .toList(),
        isRow: true,
      ),
    );
  }
}
