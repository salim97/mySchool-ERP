// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) {
  return SectionModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$SectionModelToJson(SectionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
    };
