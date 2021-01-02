// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingHoursModel _$WorkingHoursModelFromJson(Map<String, dynamic> json) {
  return WorkingHoursModel(
    id: json['id'] as int,
    class_hour_name: json['class_hour_name'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$WorkingHoursModelToJson(WorkingHoursModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class_hour_name': instance.class_hour_name,
      'from': instance.from,
      'to': instance.to,
      'type': instance.type,
    };
