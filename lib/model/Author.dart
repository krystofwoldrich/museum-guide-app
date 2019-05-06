import 'package:meta/meta.dart';

@immutable
class Author {
  final String id;
  final String name;
  final String description;
  final DateTime born;
  final DateTime died;

  Author({
    this.id,
    this.name,
    this.description,
    this.born,
    this.died
  });
}
