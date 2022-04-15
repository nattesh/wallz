import 'package:wallz/models/avatar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wallz/models/avatar.dart';

part 'uploader.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Uploader {

  String username;
  String group;
  Avatar avatar;

  Uploader(this.username, this.group, this.avatar);

  factory Uploader.fromJson(Map<String, dynamic> json) => _$UploaderFromJson(json);
  Map<String, dynamic> toJson() => _$UploaderToJson(this);
}