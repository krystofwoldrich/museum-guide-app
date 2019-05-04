import 'package:meta/meta.dart';
import 'package:museum_guide_app/helpers/SearchResultType.dart';

@immutable
class SearchResult {
  final String id;
  final String title;
  final String description;
  final SearchResultType searchResultType;

  SearchResult({
    this.id,
    this.title,
    this.description,
    this.searchResultType
  });
}
