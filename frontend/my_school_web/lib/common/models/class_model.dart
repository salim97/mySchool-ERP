import 'package:json_annotation/json_annotation.dart';

part 'class_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class ClassModel {
  int id;
  String name;
  String number;
  String capacity;
  DateTime starting_on;
  DateTime ending_on;
  String location;
  String teacher_name;
  int teacher_id;

  ClassModel({
    this.name,
    this.number,
    this.capacity,
    this.starting_on,
    this.ending_on,
    this.location,
    this.teacher_name,
    this.teacher_id,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => _$ClassModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClassModelToJson(this);
}
