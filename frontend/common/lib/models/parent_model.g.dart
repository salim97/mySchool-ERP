// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentModel _$ParentModelFromJson(Map<String, dynamic> json) {
  return ParentModel(
    id: json['id'] as int,
    first_name: json['first_name'] as String,
    middle_name: json['middle_name'] as String,
    last_name: json['last_name'] as String,
    phone: json['phone'] as String,
    email_address: json['email_address'] as String,
    username: json['username'] as String,
    children_id: (json['children_id'] as List).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$ParentModelToJson(ParentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'middle_name': instance.middle_name,
      'last_name': instance.last_name,
      'phone': instance.phone,
      'email_address': instance.email_address,
      'username': instance.username,
      'children_id': instance.children_id,
    };
