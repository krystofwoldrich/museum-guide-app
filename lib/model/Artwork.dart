import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Author.dart';

@immutable
class Artwork {
  final String id;
  final String title;
  final String description;
  final DateTime made;
  final Author author;
  final String coverPictureUrl;

  Artwork({
    this.id,
    this.title,
    this.description,
    this.made,
    this.author,
    this.coverPictureUrl,
    });
}
