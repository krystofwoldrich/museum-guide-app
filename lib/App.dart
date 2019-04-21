import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './reducer.dart' show appReducer;
import './AppState.dart';
import './theme/theme.dart';
import './routes/MainRoutes.dart';
import './screens/Dashboard.dart';

class MyApp extends StatelessWidget {
  final applicationTitle = 'Museum Guide';
  final store = Store<AppState>(
    appReducer, 
    initialState: initialState,
    middleware: [thunkMiddleware],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = {
      MainRoutes.dashboard: _buildDashboard,
      MainRoutes.tickets: _buildTickets,
      MainRoutes.map: _buildMap,
      MainRoutes.search: _buildSearch,
    };

    final app = MaterialApp(
      title: applicationTitle,
      theme: customThemeData,
      initialRoute: MainRoutes.dashboard,
      routes: routes,
    );

    return StoreProvider<AppState>(
      store: this.store,
      child: app,
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return Dashboard();
  }

  Widget _buildTickets(BuildContext context) {
    throw Exception('Method not implemented.');
  }

  Widget _buildMap(BuildContext context) {
    throw Exception('Method not implemented.');
  }

  Widget _buildSearch(BuildContext context) {
    throw Exception('Method not implemented.');
  }
}
