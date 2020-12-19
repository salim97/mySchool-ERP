// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamModel _$ExamModelFromJson(Map<String, dynamic> json) {
  return ExamModel(
    id: json['id'] as int,
    class_name: json['class_name'] as String,
    class_id: json['class_id'] as String,
    name: json['name'] as String,
    starting_date: DateTime.parse(json['starting_date'] as String),
    end_date: DateTime.parse(json['end_date'] as String),
  );
}

Map<String, dynamic> _$ExamModelToJson(ExamModel instance) => <String, dynamic>{
      'id': instance.id,
      'class_name': instance.class_name,
      'class_id': instance.class_id,
      'name': instance.name,
      'starting_date': instance.starting_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
    };
