// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opinion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Opinion _$$_OpinionFromJson(Map<String, dynamic> json) => _$_Opinion(
      id: json['id'] as String,
      opinion: json['opinion'] as String,
      createTime: DateTime.parse(json['createTime'] as String),
    );

Map<String, dynamic> _$$_OpinionToJson(_$_Opinion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'opinion': instance.opinion,
      'createTime': instance.createTime.toIso8601String(),
    };
