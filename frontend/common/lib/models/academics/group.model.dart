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

  @JsonKey(ignore: true)
  List<StudentModel> children;

  GroupModel({
    this.id,
    this.name,
    this.createdAt,
    this.section,
  }) {
    children = new List<StudentModel>();
  }

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    GroupModel model = _$GroupModelFromJson(json);
    if (json["section"] != null) {
      model.section = SectionModel.fromJson(json["section"]);
    }
    List<dynamic> children_ids = json["children"];
    children_ids.forEach((element) {
      model.children.add(StudentModel.fromJson(element));
    });
    return model;
  }

  Map<String, dynamic> toJson() {
    // return _$StudentModelToJson(this);
    Map<String, dynamic> map = _$GroupModelToJson(this);
    map["section"] = section.toJson();
    // map["section"] = section.id;
    var children_ids = new List<dynamic>();
    children.forEach((element) {
      children_ids.add(element.toJson());
    });
    map["children"] = children_ids;
    return map;
  }
}
