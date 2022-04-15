import 'package:wallz/models/uploader.dart';
import 'package:wallz/models/thumbs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailData {

  String id;
  String url;
  String shortUrl;
  Uploader uploader;

  DetailData(this.id, this.url, this.shortUrl, this.uploader);

  factory DetailData.fromJson(Map<String, dynamic> json) => _$DetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$DetailDataToJson(this);
}