import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
  includeIfNull: false,
)
class UserModel {
  @JsonKey(name: '_id')
  String id;
  String fcmToken;
  String email;
  String password;
  String role;
  String photo;

  UserModel({
    this.id,
    this.email,
    this.fcmToken,
    this.role,
    this.photo,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
