// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
      DetailData.fromJson(json['data'] as Map<String, dynamic>),
      json['views'] as int,
      json['favorites'] as int,
      json['source'] as String,
      json['purity'] as String,
      json['category'] as String,
      json['dimension_x'] as int,
      json['dimension_y'] as int,
      json['resolution'] as String,
      json['ratio'] as String,
      (json['file_size'] as num).toDouble(),
      json['file_type'] as String,
      DateTime.parse(json['created_at'] as String),
      (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      json['path'] as String,
      Thumbs.fromJson(json['thumbs'] as Map<String, dynamic>),
      (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      'data': instance.data,
      'views': instance.views,
      'favorites': instance.favorites,
      'source': instance.source,
      'purity': instance.purity,
      'category': instance.category,
      'dimension_x': instance.dimensionX,
      'dimension_y': instance.dimensionY,
      'resolution': instance.resolution,
      'ratio': instance.ratio,
      'file_size': instance.fileSize,
      'file_type': instance.fileType,
      'created_at': instance.createdAt.toIso8601String(),
      'colors': instance.colors,
      'path': instance.path,
      'thumbs': instance.thumbs,
      'tags': instance.tags,
    };
