import 'package:meta/meta.dart';

@immutable
class Multimedia {
  final String id;
  final String name;
  final String type;
  final String fileUrl;

  Multimedia({
    this.id,
    this.name,
    this.type,
    this.fileUrl
  });
}
