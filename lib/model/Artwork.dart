import 'package:meta/meta.dart';

@immutable
class Artwork {
  final String id;
  final String title;
  final String description;
  final DateTime made;

  Artwork({
    this.id,
    this.title,
    this.description,
    this.made
  });
}
