import 'package:json_annotation/json_annotation.dart';

import '../../common.dart';

part 'notification.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class NotificationModel {
  @JsonKey(name: '_id')
  String id;
  String title;
  String message;
  String type;

  List<String> topic;
  get topicAsString {
    String tmp = "";
    topic.forEach((element) {
      tmp += element + ", ";
    });
    return tmp;
  }

  @JsonKey(ignore: true)
  UserModel senderInfo = new UserModel();
  @JsonKey(ignore: true)
  List<UserModel> targetUsers;

  String createdAt;
  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.topic,
    this.type,
    this.createdAt,
  }) {
    targetUsers = List<UserModel>();
    // topic = List<String>();
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    NotificationModel notificationModel = _$NotificationModelFromJson(json);
    if (json["senderInfo"] != null) {
      notificationModel.senderInfo = UserModel.fromJson(json["senderInfo"]);
    }
    // List<dynamic> children_ids = json["targetUsers"];
    // children_ids.forEach((element) {
    //   notificationModel.targetUsers.add(UserModel.fromJson(element));
    // });
    return notificationModel;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = _$NotificationModelToJson(this);
    map["senderInfo"] = senderInfo.toJson();
    // var children_ids = new List<dynamic>();
    // targetUsers.forEach((element) {
    //   children_ids.add(element.toJson());
    // });
    // map["targetUsers"] = children_ids;
    return map;
  }
}
