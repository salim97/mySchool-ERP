import 'package:common/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class StudentModel {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(ignore: true)
  UserModel userAccount = new UserModel();
  String parent_id;
  // personal details
  String gender;
  String first_name;
  String middle_name;
  String last_name;
  String date_of_birth;
  String blood_group;
  String phone;
  get name => first_name + " " + middle_name + " " + last_name;
// address:
  String street_address;
  String city_name;
  String country;
  String pin_code;

// school details:
  String joining_date;
  String leaving_date;
  String current_position;
  String rollNo;
  String working_hours;

  StudentModel(
      {this.id,
      this.parent_id,
      this.gender,
      this.first_name,
      this.middle_name,
      this.last_name,
      this.date_of_birth,
      this.blood_group,
      this.phone,
      this.street_address,
      this.city_name,
      this.country,
      this.pin_code,
      this.joining_date,
      this.leaving_date,
      this.current_position,
      this.rollNo,
      this.working_hours});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    StudentModel studentModel = _$StudentModelFromJson(json);
    studentModel.userAccount = UserModel.fromJson(json["user"]);
    return studentModel;
  }

  Map<String, dynamic> toJson() {
    // return _$StudentModelToJson(this);
    Map<String, dynamic> map = _$StudentModelToJson(this);
    map["user"] = userAccount.id;
    return map;
  }
}
