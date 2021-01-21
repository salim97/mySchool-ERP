// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    id: json['_id'] as String,
    title: json['title'] as String,
    message: json['message'] as String,
    topic: (json['topic'] as List).map((e) => e as String).toList(),
    type: json['type'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'topic': instance.topic,
      'createdAt': instance.createdAt,
    };
