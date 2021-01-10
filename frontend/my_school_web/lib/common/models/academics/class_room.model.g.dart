// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_room.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassRoomModel _$ClassRoomModelFromJson(Map<String, dynamic> json) {
  return ClassRoomModel(
    room_number: json['room_number'] as String,
    capacity: json['capacity'] as int,
    id: json['_id'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$ClassRoomModelToJson(ClassRoomModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'room_number': instance.room_number,
      'capacity': instance.capacity,
      'createdAt': instance.createdAt,
    };
