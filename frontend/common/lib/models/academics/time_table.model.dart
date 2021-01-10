import 'package:json_annotation/json_annotation.dart';

import '../../common.dart';

part 'time_table.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class TimeTableModel {
  @JsonKey(name: '_id')
  final String id;
  final String createdAt;
  GroupModel groupid;
  SectionModel sectionid;
  TimeTableModel({
    this.id,
    this.createdAt,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) {
    TimeTableModel model = _$TimeTableModelFromJson(json);
    if (json["groupid"] != null) model.groupid = GroupModel.fromJson(json["groupid"]);
    if (json["sectionid"] != null) model.sectionid = SectionModel.fromJson(json["sectionid"]);

    return model;
  }

  Map<String, dynamic> toJson() {
    // return _$StudentModelToJson(this);
    Map<String, dynamic> map = _$TimeTableModelToJson(this);
    map["groupid"] = groupid.toJson();
    map["sectionid"] = sectionid.toJson();
    return map;
  }
}
