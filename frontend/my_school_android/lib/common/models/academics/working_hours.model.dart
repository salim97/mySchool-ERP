import 'package:json_annotation/json_annotation.dart';

part 'working_hours.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class WorkingHoursModel {
  @JsonKey(name: '_id')
  String id;
  String class_hour_name;
  String startTime;
  String endTime;
  String type;

  WorkingHoursModel({
    this.id,
    this.class_hour_name,
    this.startTime,
    this.endTime,
    this.type,
  });

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) => _$WorkingHoursModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkingHoursModelToJson(this);
}
