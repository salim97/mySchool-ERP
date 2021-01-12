import '../../common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher_subject.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class TeacherSubjectModel {
  @JsonKey(name: '_id')
   String id;
   String createdAt;
  TeacherModel teacherid;
  SubjectModel subjectid;
  TeacherSubjectModel({
    this.id,
    this.createdAt,
  });

  factory TeacherSubjectModel.fromJson(Map<String, dynamic> json) {
    TeacherSubjectModel model = _$TeacherSubjectModelFromJson(json);
    if (json["teacherid"] != null) model.teacherid = TeacherModel.fromJson(json["teacherid"]);
    if (json["subjectid"] != null) model.subjectid = SubjectModel.fromJson(json["subjectid"]);

    return model;
  }

  Map<String, dynamic> toJson() {
    // return _$StudentModelToJson(this);
    Map<String, dynamic> map = _$TeacherSubjectModelToJson(this);
    map["teacherid"] = teacherid.toJson();
    map["subjectid"] = subjectid.toJson();
    return map;
  }
}
