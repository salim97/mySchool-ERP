import 'package:json_annotation/json_annotation.dart';

part 'subject.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class SubjectModel {
  @JsonKey(name: '_id')
  String id;
  String name;
  String code;
  String type;

  SubjectModel({
    this.id,
    this.name,
    this.code,
    this.type,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => _$SubjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
