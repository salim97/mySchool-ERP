import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'teacher_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class TeacherModel {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(ignore: true)
  UserModel userAccount = new UserModel();
  // personal details
  String gender;
  String full_name;
  String date_of_birth;
  String blood_group;
  String phone;
  String qualification;
  String subjects_handling;
  String incharge_class;
// address:
  String street_address;
  String city_name;
  String country;
  String pin_code;

// school details:
  String joining_date;
  String leaving_date;
  String current_position;
  String employee_code;
  String working_hours;

  TeacherModel({
    this.id,
    this.gender,
    this.full_name,
    this.date_of_birth,
    this.blood_group,
    this.phone,
    this.qualification,
    this.street_address,
    this.city_name,
    this.country,
    this.pin_code,
    this.joining_date,
    this.leaving_date,
    this.current_position,
    this.employee_code,
    this.working_hours,
    this.subjects_handling,
    this.incharge_class,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    TeacherModel teacherModel = _$TeacherModelFromJson(json);
    teacherModel.userAccount = UserModel.fromJson(json["user"]);
    return teacherModel;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = _$TeacherModelToJson(this);
    map["user"] = userAccount.id;
    return map;
  }
}
