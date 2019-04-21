import 'package:meta/meta.dart';

@immutable
class Ticket {
  final String id;
  final String name;
  final String description;
  final double price;

  Ticket({
    this.id,
    this.name,
    this.description,
    this.price
  });
}
