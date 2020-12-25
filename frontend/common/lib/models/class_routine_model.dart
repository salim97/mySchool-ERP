import 'package:json_annotation/json_annotation.dart';

part 'class_routine_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class ClassRoutineModel {
  int id;
  String startTime;
  String endTime;
  String subject;
  String room;

  ClassRoutineModel({
    this.id,
    this.startTime,
    this.endTime,
    this.subject,
    this.room,
  });

  factory ClassRoutineModel.fromJson(Map<String, dynamic> json) => _$ClassRoutineModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClassRoutineModelToJson(this);
}
