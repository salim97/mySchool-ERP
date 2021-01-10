// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) {
  return SubjectModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'type': instance.type,
    };
