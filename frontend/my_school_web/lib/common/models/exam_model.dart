import 'package:json_annotation/json_annotation.dart';

part 'exam_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class ExamModel {
  int id;
  String class_name;
  String class_id;
  String name;
  DateTime starting_date;
  DateTime end_date;

  ExamModel({
    this.id,
    this.class_name,
    this.class_id,
    this.name,
    this.starting_date,
    this.end_date,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => _$ExamModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExamModelToJson(this);
}
