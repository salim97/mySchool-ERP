// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_routine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassRoutineModel _$ClassRoutineModelFromJson(Map<String, dynamic> json) {
  return ClassRoutineModel(
    id: json['id'] as int,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    subject: json['subject'] as String,
    room: json['room'] as String,
  );
}

Map<String, dynamic> _$ClassRoutineModelToJson(ClassRoutineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'subject': instance.subject,
      'room': instance.room,
    };
