import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
  includeIfNull: false,
)
class UserModel {
  int id;
  String email;
  String auth_type;
  String password;
  String token;
  String role;

  UserModel({this.id, this.email, this.auth_type, this.password, this.token, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
