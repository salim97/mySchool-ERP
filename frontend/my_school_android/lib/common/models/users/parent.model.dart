import 'student.model.dart';
import 'user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent.model.g.dart';

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
  String name;
  String phone;
  String gender;
  String date_of_birth;

  ParentModel({
    this.id,
    this.phone,
    this.name,
    this.gender,
    this.date_of_birth,
    this.children,
  }) {
    children = new List<StudentModel>();
  }

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    ParentModel parentModel = _$ParentModelFromJson(json);
    if (json["user"] != null) {
      parentModel.userAccount = UserModel.fromJson(json["user"]);
    }
    List<dynamic> children_ids = json["children"];
    children_ids.forEach((element) {
      parentModel.children.add(StudentModel.fromJson(element));
    });
    return parentModel;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = _$ParentModelToJson(this);
    map["user"] = userAccount.toJson();
    var children_ids = new List<dynamic>();
    children.forEach((element) {
      children_ids.add(element.toJson());
    });
    map["children"] = children_ids;
    return map;
  }
}
