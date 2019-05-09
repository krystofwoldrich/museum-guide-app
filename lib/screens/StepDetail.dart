import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:museum_guide_app/AppState.dart';
import 'package:museum_guide_app/model/Step.dart' as StepModel;
import 'package:museum_guide_app/widgets/Section.dart';

class StepDetail extends StatefulWidget {
  final int actualStepIndex;
  final List<StepModel.Step> steps;

  StepDetail({@required this.actualStepIndex, @required this.steps});

  @override
  State<StatefulWidget> createState() {
    return StepDetailState(actualStepIndex: actualStepIndex, steps: steps);
  }
}

class StepDetailState extends State<StepDetail> {
  final int actualStepIndex;
  final List<StepModel.Step> steps;

  StepDetailState({@required this.actualStepIndex, @required this.steps});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StepModel.Step>(
      converter: (store) {
        return steps.where((step) => step.index == actualStepIndex).first;
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

    content.add(Image.network("https://museum-guide-api.herokuapp.com" + step.coverPictureUrl));
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
