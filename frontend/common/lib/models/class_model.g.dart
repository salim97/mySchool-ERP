// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassModel _$ClassModelFromJson(Map<String, dynamic> json) {
  return ClassModel(
    name: json['name'] as String,
    number: json['number'] as String,
    capacity: json['capacity'] as String,
    starting_on: DateTime.parse(json['starting_on'] as String),
    ending_on: DateTime.parse(json['ending_on'] as String),
    location: json['location'] as String,
    teacher_name: json['teacher_name'] as String,
    teacher_id: json['teacher_id'] as int,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$ClassModelToJson(ClassModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'capacity': instance.capacity,
      'starting_on': instance.starting_on.toIso8601String(),
      'ending_on': instance.ending_on.toIso8601String(),
      'location': instance.location,
      'teacher_name': instance.teacher_name,
      'teacher_id': instance.teacher_id,
    };
