import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Location.dart';
import 'package:museum_guide_app/model/Multimedia.dart';

@immutable
class Step {
  final String id;
  final String title;
  final String description;
  final int index;
  final String coverPictureUrl;
  final Location location;
  final List<Multimedia> multimedias;

  Step({
    this.id,
    this.title,
    this.description,
    this.index,
    this.coverPictureUrl,
    this.location,
    this.multimedias
  });
}
