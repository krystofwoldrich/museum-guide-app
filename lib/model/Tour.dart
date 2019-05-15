import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Step.dart';

@immutable
class Tour {
  final String id;
  final String name;
  final String description;
  final String coverPictureUrl;
  final List<Step> steps;
  final double lengthInHours;

  Tour({
    this.id,
    this.name,
    this.description,
    this.coverPictureUrl,
    this.steps,
    this.lengthInHours,
  });
}
