import 'package:meta/meta.dart';
import 'package:museum_guide_app/model/Artwork.dart';

@immutable
class Section {
  final String id;
  final String name;
  final String description;
  final String coverPictureUrl;
  final List<Artwork> artworks;

  Section({
    this.id,
    this.name,
    this.description,
    this.coverPictureUrl,
    this.artworks = const [],
  });

  Section copyWith({
    String id,
    String name,
    String description,
    String coverPictureUrl,
    List<Artwork> artworks,
  }) {
    return Section(
      id: id ?? this.id, 
      name: name ?? this.name, 
      description: description ?? this.description, 
      coverPictureUrl: coverPictureUrl ?? this.coverPictureUrl, 
      artworks: artworks ?? this.artworks, 
    );
  }
}
