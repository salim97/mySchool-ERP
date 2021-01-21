import 'package:json_annotation/json_annotation.dart';

import '../../common.dart';

part 'time_table.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class TimeTableModel {
  @JsonKey(name: '_id')
  String id;
  String createdAt;
  GroupModel groupid;
  @JsonKey(ignore: true)
  List<OneTimeTable> children;
  TimeTableModel({
    this.id,
    this.createdAt,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) {
    TimeTableModel model = _$TimeTableModelFromJson(json);
    if (json["groupid"] != null) model.groupid = GroupModel.fromJson(json["groupid"]);
    List<dynamic> children_ids = json["children"];
    children_ids.forEach((element) {
      OneTimeTable ott = new OneTimeTable();
      ott.workingHoursModel = WorkingHoursModel.fromJson(element["workingHoursid"]);
      ott.classRoomModel = ClassRoomModel.fromJson(element["classRoomid"]);
      ott.teacherSubjectModel = TeacherSubjectModel.fromJson(element["teacherSubjectid"]);
      ott.day = element["day"];
      if (model.children == null) model.children = new List<OneTimeTable>();
      model.children.add(ott);
    });

    return model;
  }

  Map<String, dynamic> toJson() {
    // return _$StudentModelToJson(this);
    Map<String, dynamic> map = _$TimeTableModelToJson(this);
    map["groupid"] = groupid.toJson();
    var children_temp = new List<dynamic>();
    children.forEach((element) {
      var t = new Map<String, dynamic>();
      t["workingHoursid"] = element.workingHoursModel.toJson();
      t["classRoomid"] = element.classRoomModel.toJson();
      t["teacherSubjectid"] = element.teacherSubjectModel.toJson();
      t["day"] = element.day;
      children_temp.add(t);
    });
    map["children"] = children_temp;
    return map;
  }
}

class OneTimeTable {
  String day = "";
  WorkingHoursModel workingHoursModel = new WorkingHoursModel();
  ClassRoomModel classRoomModel = new ClassRoomModel();
  TeacherSubjectModel teacherSubjectModel = new TeacherSubjectModel();
}
