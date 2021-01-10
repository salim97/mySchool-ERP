import 'package:json_annotation/json_annotation.dart';

part 'section.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class SectionModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String createdAt;
  SectionModel({
    this.id,
    this.name,
    this.createdAt,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}
