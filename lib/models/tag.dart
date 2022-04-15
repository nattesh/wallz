import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Tag {

  double id;
  String name;
  String alias;
  int categoryId;
  String category;
  String purity;
  DateTime createdAt;

  Tag(this.id, this.name, this.alias, this.categoryId, this.category,
      this.purity, this.createdAt);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}