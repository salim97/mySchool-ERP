import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.snake,
)
class UserModel {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;

  UserModel({
    this.id,
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.email = "",
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
