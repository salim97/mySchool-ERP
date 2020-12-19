import 'package:json_annotation/json_annotation.dart';

part 'working_hours_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class WorkingHoursModel {
  int id;
  String class_hour_name;
  String from;
  String to;
  String type;

  WorkingHoursModel({
    this.id,
    this.class_hour_name,
    this.from,
    this.to,
    this.type,
  });

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) => _$WorkingHoursModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkingHoursModelToJson(this);
}
