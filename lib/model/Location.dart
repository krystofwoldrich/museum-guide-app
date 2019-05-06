import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Room.dart';

@immutable
class Location {
  final String id;
  final String name;
  final Room room;

  Location({
    this.id,
    this.name,
    this.room,
  });
}
