// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return GroupModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    createdAt: json['createdAt'] as String,
  )..section = SectionModel.fromJson(json['section'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'section': instance.section,
    };
