import 'package:json_annotation/json_annotation.dart';

part 'homework_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class HomeworkModel {
  int id;
  String createdBy;
  String evaluatedBy;
  String description;
  String subjectName;
  String homeworkDate;
  String submissionDate;
  String evaluationDate;
  String fileUrl;
  String status;

  HomeworkModel({
    this.id,
    this.createdBy,
    this.evaluatedBy,
    this.description,
    this.subjectName,
    this.homeworkDate,
    this.submissionDate,
    this.evaluationDate,
    this.fileUrl,
    this.status,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) => _$HomeworkModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeworkModelToJson(this);
}
