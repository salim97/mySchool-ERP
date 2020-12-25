import 'package:json_annotation/json_annotation.dart';

part 'subject_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class SubjectModel {
  int id;
  String name;
  String code;
  String teacher_name;
  String teacher_id;
  String book_name;
  String type;

  SubjectModel({
    this.id,
    this.name,
    this.code,
    this.teacher_name,
    this.teacher_id,
    this.book_name,
    this.type,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => _$SubjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
