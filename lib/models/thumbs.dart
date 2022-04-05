import 'package:json_annotation/json_annotation.dart';

part 'thumbs.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Thumbs {

  String large;
  String original;
  String small;

  Thumbs(this.large, this.original, this.small);

  factory Thumbs.fromJson(Map<String, dynamic> json) => _$ThumbsFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbsToJson(this);

}