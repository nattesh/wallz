// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wall_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallItem _$WallItemFromJson(Map<String, dynamic> json) => WallItem(
      json['id'] as String,
      json['url'] as String,
      json['short_url'] as String,
      json['views'] as int,
      json['favorites'] as int,
      json['source'] as String,
      json['purity'] as String,
      json['category'] as String,
      json['dimension_x'] as int,
      json['dimension_y'] as int,
      json['resolution'] as String,
      json['ratio'] as String,
      json['file_size'] as int,
      json['file_type'] as String,
      DateTime.parse(json['created_at'] as String),
      (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      json['path'] as String,
      Thumbs.fromJson(json['thumbs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WallItemToJson(WallItem instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'short_url': instance.shortUrl,
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
    };
