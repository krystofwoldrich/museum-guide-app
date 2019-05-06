import 'package:meta/meta.dart';

@immutable
class Room {
  final String id;
  final String name;
  final String number;

  Room({
    this.id,
    this.name,
    this.number,
  });
}
