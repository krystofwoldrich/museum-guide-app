import 'package:flutter/material.dart';
import 'package:museum_guide_app/actions/exhibitions.dart';
import 'package:museum_guide_app/model/Exhibition.dart';
import 'package:museum_guide_app/screens/ExhibitionList.dart';
import 'package:museum_guide_app/widgets/cards/ExhibitionCard.dart';
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
    if (StoreProvider.of<AppState>(context).state.tickets.length == 0) {
      StoreProvider.of<AppState>(context).dispatch(getTickets);
    }
    if (StoreProvider.of<AppState>(context).state.exhibitions.length == 0) {    
      StoreProvider.of<AppState>(context).dispatch(getActualExhibitions);
    }

    return this._getContent(context);
  }

  Widget _getContent(BuildContext context) {
    final List<Widget> dashboardContent = [];

    dashboardContent.add(ScreenTitle(this._title));
    dashboardContent.add(this._createTickets());
    dashboardContent.add(this._createExhibitions(context));

    return PageContentContainer(
      child: ListView(
        children: dashboardContent,
      ),
    );
  }

  Widget _createTickets() {
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

  Widget _createExhibitions(BuildContext context) {
    return StoreConnector<AppState, List<Exhibition>>(
      converter: (store) => store.state.exhibitions,
      builder: (_, List<Exhibition> tickets) => Section(
        title: 'Exhibitions',
        content: tickets
          .map((Exhibition exhibition) => ExhibitionCard(
            id: exhibition.id,
            title: exhibition.title,
            description: exhibition.description,
          ))
          .toList(),
        onMore: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ExhibitionList(),
          ));
        },
      ),
    );
  }
}
