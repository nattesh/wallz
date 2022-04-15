// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailData _$DetailDataFromJson(Map<String, dynamic> json) => DetailData(
      json['id'] as String,
      json['url'] as String,
      json['short_url'] as String,
      Uploader.fromJson(json['uploader'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailDataToJson(DetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'short_url': instance.shortUrl,
      'uploader': instance.uploader,
    };
