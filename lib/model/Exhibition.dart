import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Section.dart';

@immutable
class Exhibition {
  final String id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final List<Section> sections;

  Exhibition({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
    this.sections
  });
}