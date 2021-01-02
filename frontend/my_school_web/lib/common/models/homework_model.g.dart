// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeworkModel _$HomeworkModelFromJson(Map<String, dynamic> json) {
  return HomeworkModel(
    id: json['id'] as int,
    createdBy: json['createdBy'] as String,
    evaluatedBy: json['evaluatedBy'] as String,
    description: json['description'] as String,
    subjectName: json['subjectName'] as String,
    homeworkDate: json['homeworkDate'] as String,
    submissionDate: json['submissionDate'] as String,
    evaluationDate: json['evaluationDate'] as String,
    fileUrl: json['fileUrl'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$HomeworkModelToJson(HomeworkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'evaluatedBy': instance.evaluatedBy,
      'description': instance.description,
      'subjectName': instance.subjectName,
      'homeworkDate': instance.homeworkDate,
      'submissionDate': instance.submissionDate,
      'evaluationDate': instance.evaluationDate,
      'fileUrl': instance.fileUrl,
      'status': instance.status,
    };
