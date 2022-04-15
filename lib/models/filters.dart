import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Filters {

  String ratios = 'portrait';
  String categories = '100';
  String purity = '100';
  String sorting = 'date_added';
  String order = 'desc';
  String colors = '';
  String tagName =  '';

  Filters(this.ratios, this.categories, this.purity, this.sorting, this.order,
      this.colors, this.tagName);

  factory Filters.fromJson(Map<String, dynamic> json) => _$FiltersFromJson(json);
  Map<String, dynamic> toJson() => _$FiltersToJson(this);


}