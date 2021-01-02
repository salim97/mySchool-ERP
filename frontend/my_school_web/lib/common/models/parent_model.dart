import 'student_model.dart';
import 'user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class ParentModel {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(ignore: true)
  UserModel userAccount = new UserModel();
  @JsonKey(ignore: true)
  List<StudentModel> children;

  // personal details

  String phone;
  String gender;
  String date_of_birth;

  ParentModel({
    this.id,
    this.phone,
    this.gender,
    this.date_of_birth,
    this.children,
  }) {
    children = new List<StudentModel>();
  }

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    ParentModel parentModel = _$ParentModelFromJson(json);
    parentModel.userAccount = UserModel.fromJson(json["user"]);
    List<dynamic> children_ids = json["children"];
    children_ids.forEach((element) {
      parentModel.children.add(StudentModel.fromJson(element));
    });
    return parentModel;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = _$ParentModelToJson(this);
    map["user"] = userAccount.id;
    var children_ids = new List<String>();
    children.forEach((element) {
      children_ids.add(element.id);
    });
    map["children"] = children_ids;
    return map;
  }
}
