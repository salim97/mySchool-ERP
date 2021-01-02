import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
  includeIfNull: false,
)
class UserModel {
  @JsonKey(name: '_id')
  String id;
  String name;
  String email;
  String password;
  String role;
  String photo;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.photo,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
