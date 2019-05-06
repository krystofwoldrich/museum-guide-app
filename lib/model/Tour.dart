import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Step.dart';

@immutable
class Tour {
  final String id;
  final String name;
  final String description;
  final List<Step> steps;

  Tour({
    this.id,
    this.name,
    this.description,
    this.steps
  });
}
