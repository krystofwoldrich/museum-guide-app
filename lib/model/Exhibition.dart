import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Section.dart';
import 'package:museum_guide_app/model/Tour.dart';

@immutable
class Exhibition {
  final String id;
  final String title;
  final String description;
  final String coverPictureUrl;
  final DateTime from;
  final DateTime to;
  final List<Section> sections;
  final List<Tour> tours;

  Exhibition({
    this.id,
    this.title,
    this.description,
    this.coverPictureUrl,
    this.from,
    this.to,
    this.sections,
    this.tours,
  });

  Exhibition copyWith({
    String id,
    String title,
    String description,
    String coverPictureUrl,
    DateTime from,
    DateTime to,
    List<Section> sections,
    List<Tour> tours,
  }) {
    return Exhibition(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverPictureUrl: coverPictureUrl ?? this.coverPictureUrl,
      from: from ?? this.from,
      to: to ?? this.to,
      sections: sections ?? this.sections,
      tours: tours ?? this.tours,
    );
  }
}
