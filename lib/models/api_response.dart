import 'package:json_annotation/json_annotation.dart';
import 'package:wallz/models/wall_item.dart';
import 'package:wallz/models/meta.dart';

part 'api_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiResponse {

  List<WallItem> data;
  Meta meta;

  ApiResponse(this.data, this.meta);

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

}