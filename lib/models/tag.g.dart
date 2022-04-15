// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      (json['id'] as num).toDouble(),
      json['name'] as String,
      json['alias'] as String,
      json['category_id'] as int,
      json['category'] as String,
      json['purity'] as String,
      DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alias': instance.alias,
      'category_id': instance.categoryId,
      'category': instance.category,
      'purity': instance.purity,
      'created_at': instance.createdAt.toIso8601String(),
    };
