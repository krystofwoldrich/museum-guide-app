import 'package:meta/meta.dart';

@immutable
class Exhibition {
  final String id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;

  Exhibition({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to
  });
}
