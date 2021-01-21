import 'package:json_annotation/json_annotation.dart';

part 'attendance.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class AttendanceModel {
  @JsonKey(name: '_id')
  String id;
  String date;
  String type;
  String createdAt;
  AttendanceModel({
    this.date,
    this.type,
    this.id,
    this.createdAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => _$AttendanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}
