import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Meta {

  int currentPage;
  int lastPage;
  int perPage;
  int total;
  String query;

  Meta(this.currentPage, this.lastPage, this.perPage, this.total, this.query);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}