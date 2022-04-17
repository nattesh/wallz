// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryFilter _$QueryFilterFromJson(Map<String, dynamic> json) => QueryFilter(
      json['tag_name'] as String,
      json['username'] as String,
      json['like'] as String,
    );

Map<String, dynamic> _$QueryFilterToJson(QueryFilter instance) =>
    <String, dynamic>{
      'tag_name': instance.tagName,
      'username': instance.username,
      'like': instance.like,
    };
