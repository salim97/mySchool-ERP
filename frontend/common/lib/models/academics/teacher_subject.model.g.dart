// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_subject.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherSubjectModel _$TeacherSubjectModelFromJson(Map<String, dynamic> json) {
  return TeacherSubjectModel(
    id: json['_id'] as String,
    createdAt: json['createdAt'] as String,
  )
    ..teacherid =
        TeacherModel.fromJson(json['teacherid'] as Map<String, dynamic>)
    ..subjectid =
        SubjectModel.fromJson(json['subjectid'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TeacherSubjectModelToJson(
        TeacherSubjectModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'teacherid': instance.teacherid,
      'subjectid': instance.subjectid,
    };
