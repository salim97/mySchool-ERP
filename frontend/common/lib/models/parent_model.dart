import 'package:json_annotation/json_annotation.dart';

part 'parent_model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class ParentModel {
  int id;
  // personal details
  String first_name;
  String middle_name;
  String last_name;
  String phone;

// account information:
  String email_address;
  String username;
  List<int> children_id;

  ParentModel(
      {this.id, this.first_name, this.middle_name, this.last_name, this.phone, this.email_address, this.username, this.children_id});

  factory ParentModel.fromJson(Map<String, dynamic> json) => _$ParentModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParentModelToJson(this);
}
