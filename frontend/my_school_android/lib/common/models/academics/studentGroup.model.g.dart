// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentGroup.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentGroupModel _$StudentGroupModelFromJson(Map<String, dynamic> json) {
  return StudentGroupModel(
    id: json['_id'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$StudentGroupModelToJson(StudentGroupModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      '_id': instance.id,
    };
