// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) {
  return SubjectModel(
    id: json['id'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    teacher_name: json['teacher_name'] as String,
    teacher_id: json['teacher_id'] as String,
    book_name: json['book_name'] as String,
  );
}

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'teacher_name': instance.teacher_name,
      'teacher_id': instance.teacher_id,
      'book_name': instance.book_name,
    };
