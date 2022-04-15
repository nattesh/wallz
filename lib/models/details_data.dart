import 'package:wallz/models/uploader.dart';
import 'package:wallz/models/thumbs.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wallz/models/thumbs.dart';
import 'package:wallz/models/tag.dart';

part 'details_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailsData {

  String id;
  String url;
  String shortUrl;
  Uploader uploader;
  int views;
  int favorites;
  String source;
  String purity;
  String category;
  int dimensionX;
  int dimensionY;
  String resolution;
  String ratio;
  double fileSize;
  String fileType;
  DateTime createdAt;
  List<String> colors;
  String path;
  Thumbs thumbs;
  List<Tag> tags;


  DetailsData(
      this.id,
      this.url,
      this.shortUrl,
      this.uploader,
      this.views,
      this.favorites,
      this.source,
      this.purity,
      this.category,
      this.dimensionX,
      this.dimensionY,
      this.resolution,
      this.ratio,
      this.fileSize,
      this.fileType,
      this.createdAt,
      this.colors,
      this.path,
      this.thumbs,
      this.tags);

  factory DetailsData.fromJson(Map<String, dynamic> json) => _$DetailsDataFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsDataToJson(this);
}