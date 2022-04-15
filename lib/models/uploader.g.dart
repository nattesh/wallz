// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploader.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uploader _$UploaderFromJson(Map<String, dynamic> json) => Uploader(
      json['username'] as String,
      json['group'] as String,
      Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploaderToJson(Uploader instance) => <String, dynamic>{
      'username': instance.username,
      'group': instance.group,
      'avatar': instance.avatar,
    };
