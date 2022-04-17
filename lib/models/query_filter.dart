import 'package:json_annotation/json_annotation.dart';

part 'query_filter.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QueryFilter {
  String tagName;
  String username;
  String like;

  QueryFilter(this.tagName, this.username, this.like);

  factory QueryFilter.fromJson(Map<String, dynamic> json) => _$QueryFilterFromJson(json);
  Map<String, dynamic> toJson() => _$QueryFilterToJson(this);
}