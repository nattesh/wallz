// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      json['ratios'] as String,
      json['categories'] as String,
      json['purity'] as String,
      json['sorting'] as String,
      json['order'] as String,
      json['api_key'] as String,
      json['tag_name'] as String,
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'ratios': instance.ratios,
      'categories': instance.categories,
      'purity': instance.purity,
      'sorting': instance.sorting,
      'order': instance.order,
      'api_key': instance.apiKey,
      'tag_name': instance.tagName,
    };
