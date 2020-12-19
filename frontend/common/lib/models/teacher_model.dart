import 'package:json_annotation/json_annotation.dart';

part 'teacher_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class TeacherModel {
  int id;
  // personal details
  String gender;
  String first_name;
  String middle_name;
  String last_name;
  String date_of_birth;
  String blood_group;
  String phone;
  String qualification;
  String subjects_handling;
  String incharge_class;
  get name => first_name + " " + middle_name + " " + last_name;
// address:
  String street_address;
  String city_name;
  String country;
  String pin_code;

// account information:
  String email_address;
  String username;

// school details:
  String joining_date;
  String leaving_date;
  String current_position;
  String employee_code;
  String working_hours;

  TeacherModel({
    this.id,
    this.gender,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.date_of_birth,
    this.blood_group,
    this.phone,
    this.qualification,
    this.street_address,
    this.city_name,
    this.country,
    this.pin_code,
    this.email_address,
    this.username,
    this.joining_date,
    this.leaving_date,
    this.current_position,
    this.employee_code,
    this.working_hours,
    this.subjects_handling,
    this.incharge_class,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => _$TeacherModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);
}
