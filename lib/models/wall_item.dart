import 'package:wallz/models/thumbs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wall_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WallItem {
  String id;
  String url;
  String shortUrl;
  int views;
  int favorites;
  String source;
  String purity;
  String category;
  int dimensionX;
  int dimensionY;
  String resolution;
  String ratio;
  int fileSize;
  String fileType;
  DateTime createdAt;
  List<String> colors;
  String path;
  Thumbs thumbs;

  WallItem(
      this.id,
      this.url,
      this.shortUrl,
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
      this.thumbs);

  factory WallItem.fromJson(Map<String, dynamic> json) => _$WallItemFromJson(json);
  Map<String, dynamic> toJson() => _$WallItemToJson(this);
}