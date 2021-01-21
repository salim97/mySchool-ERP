// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) {
  return AttendanceModel(
    date: json['date'] as String,
    type: json['type'] as String,
    id: json['_id'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'type': instance.type,
      'createdAt': instance.createdAt,
    };
