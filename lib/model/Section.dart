import 'package:meta/meta.dart';

@immutable
class Section {
  final String id;
  final String name;
  final String description;
  final String coverPictureUrl;

  Section({
    this.id,
    this.name,
    this.description,
    this.coverPictureUrl
  });
}
