import 'package:flutter/material.dart';
import 'package:museum_guide_app/layouts/LayoutWithAppBarWithBottomNavigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './reducer.dart' show appReducer;
import './AppState.dart';
import './theme/theme.dart';

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
    return StoreProvider<AppState>(
      store: this.store,
      child: MaterialApp(
        title: applicationTitle,
        theme: customThemeData,
        home: LayoutWithAppBarWithBottomNavigation(),
      ),
    );
  }
}
