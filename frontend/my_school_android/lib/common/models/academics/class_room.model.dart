import 'package:json_annotation/json_annotation.dart';

part 'class_room.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class ClassRoomModel {
  @JsonKey(name: '_id')
   String id;
   String room_number;
   int capacity;
   String createdAt;
  ClassRoomModel({
    this.room_number,
    this.capacity,
    this.id,
    this.createdAt,
  });

  factory ClassRoomModel.fromJson(Map<String, dynamic> json) => _$ClassRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClassRoomModelToJson(this);
}
