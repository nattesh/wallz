import 'package:json_annotation/json_annotation.dart';

part 'avatar.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class Avatar {

  @JsonKey(name: '200px')
  String larger;

  @JsonKey(name: '128px')
  String large;

  @JsonKey(name: '32px')
  String medium;

  @JsonKey(name: '20px')
  String small;

  Avatar(this.larger, this.large, this.medium, this.small);

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}