import 'package:meta/meta.dart';

@immutable
class Tour {
  final String id;
  final String name;
  final String description;

  Tour({
    this.id,
    this.name,
    this.description
  });
}
