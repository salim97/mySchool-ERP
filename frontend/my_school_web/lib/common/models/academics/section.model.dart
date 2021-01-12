import 'package:json_annotation/json_annotation.dart';

part 'section.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class SectionModel {
  @JsonKey(name: '_id')
   String id;
   String name;
   String createdAt;
  SectionModel({
    this.id,
    this.name,
    this.createdAt,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}
