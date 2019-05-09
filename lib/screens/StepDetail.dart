import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/model/Step.dart' as StepModel;
import 'package:museum_guide_app/widgets/Section.dart';

class StepDetail extends StatefulWidget {
  final String tourName;
  final StepModel.Step step;
  final int stepCount;

  StepDetail(
      {@required this.tourName, @required this.step, @required this.stepCount});

  @override
  State<StatefulWidget> createState() {
    return StepDetailState(
        tourName: tourName, step: step, stepCount: stepCount);
  }
}

class StepDetailState extends State<StepDetail> with WidgetsBindingObserver {
  final int notificationId = 1;
  final String channelId = "1";
  final String channelName = "TourPaused";
  final String channelDescription = "TourPaused";
  final String tourName;
  final StepModel.Step step;
  final int stepCount;

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  StepDetailState(
      {@required this.tourName, @required this.step, @required this.stepCount});

  @override
  void initState() {
    super.initState();

    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channelId, channelName, channelDescription,
          importance: Importance.Max, priority: Priority.High);
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

      var stepIndex = step.index + 1;
      _flutterLocalNotificationsPlugin.show(
          notificationId,
          'Tour $tourName paused',
          'You went through $stepIndex/$stepCount steps. Click to continue in the tour.',
          platformChannelSpecifics);
    } else if (state == AppLifecycleState.resumed) {
      _flutterLocalNotificationsPlugin.cancel(notificationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StepModel.Step>(
      converter: (store) {
        return step;
      },
      builder: (BuildContext context, StepModel.Step step) {
        return Scaffold(
          body: this._getContent(context, step),
        );
      },
    );
  }

  Widget _getContent(BuildContext context, StepModel.Step step) {
    final List<Widget> content = [];

    content.add(Image.network(step.coverPictureUrl));
    content.add(Section(
      title: 'Description',
      content: <Widget>[
        Text(step.description != null
            ? step.description
            : 'No description available.'),
      ],
    ));

    return ListView(
      children: content,
    );
  }
}
