import '../../common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class GroupModel {
  @JsonKey(name: '_id')
   String id;
   String name;
   String createdAt;
  SectionModel section;
  GroupModel({
    this.id,
    this.name,
    this.createdAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    GroupModel model = _$GroupModelFromJson(json);
    if (json["section"] != null) {
      model.section = SectionModel.fromJson(json["section"]);
    }
    return model;
  }

  Map<String, dynamic> toJson() {
    // return _$StudentModelToJson(this);
    Map<String, dynamic> map = _$GroupModelToJson(this);
    map["section"] = section.toJson();
    // map["section"] = section.id;
    return map;
  }
}
