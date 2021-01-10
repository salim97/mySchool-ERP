import 'package:json_annotation/json_annotation.dart';

part 'class_room.model.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.none,
)
class ClassRoomModel {
  @JsonKey(name: '_id')
  final String id;
  final String room_number;
  final int capacity;
  final String createdAt;
  ClassRoomModel({
    this.room_number,
    this.capacity,
    this.id,
    this.createdAt,
  });

  factory ClassRoomModel.fromJson(Map<String, dynamic> json) => _$ClassRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClassRoomModelToJson(this);
}
