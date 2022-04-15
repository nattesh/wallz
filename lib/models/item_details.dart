import 'package:json_annotation/json_annotation.dart';
import 'package:wallz/models/detail_data.dart';
import 'package:wallz/models/thumbs.dart';
import 'package:wallz/models/tag.dart';

part 'item_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemDetails {

  DetailData data;
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

  ItemDetails(
      this.data,
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

  factory ItemDetails.fromJson(Map<String, dynamic> json) => _$ItemDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);
}