// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_hours.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingHoursModel _$WorkingHoursModelFromJson(Map<String, dynamic> json) {
  return WorkingHoursModel(
    id: json['_id'] as String,
    class_hour_name: json['class_hour_name'] as String,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$WorkingHoursModelToJson(WorkingHoursModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'class_hour_name': instance.class_hour_name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'type': instance.type,
    };
