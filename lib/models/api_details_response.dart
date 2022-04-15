import 'package:json_annotation/json_annotation.dart';
import 'package:wallz/models/details_data.dart';

part 'api_details_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiDetailsResponse {

  DetailsData data;

  ApiDetailsResponse(this.data);

  factory ApiDetailsResponse.fromJson(Map<String, dynamic> json) => _$ApiDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiDetailsResponseToJson(this);
}