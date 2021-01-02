// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentModel _$ParentModelFromJson(Map<String, dynamic> json) {
  return ParentModel(
    id: json['_id'] as String,
    phone: json['phone'] as String,
    gender: json['gender'] as String,
    date_of_birth: json['date_of_birth'] as String,
  );
}

Map<String, dynamic> _$ParentModelToJson(ParentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'phone': instance.phone,
      'gender': instance.gender,
      'date_of_birth': instance.date_of_birth,
    };
