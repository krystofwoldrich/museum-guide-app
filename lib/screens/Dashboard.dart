import 'package:flutter/material.dart';
import '../layouts/LayoutWithAppBarWithBottomNavigation.dart';
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

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getTickets);

    return LayoutWithAppBarWithBottomNavigation(
      child: this._getContent(), 
      title: this._getTextTitle(), 
      leading: null
    );
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

  Text _getTextTitle() {
    return Text(this._title);
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
