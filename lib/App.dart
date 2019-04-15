import 'package:flutter/material.dart';
import './routes/MainRoutes.dart';
import './screens/Dashboard.dart';

class MyApp extends StatelessWidget {
  final applicationTitle = 'Museum Guide';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = {
      MainRoutes.dashboard: _buildDashboard,
      MainRoutes.tickets: _buildTickets,
      MainRoutes.map: _buildMap,
      MainRoutes.search: _buildSearch,
    };

    return MaterialApp(
      title: applicationTitle,
      initialRoute: MainRoutes.dashboard,
      routes: routes,
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
