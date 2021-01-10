// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['_id'] as String,
    email: json['email'] as String,
    fcmToken: json['fcmToken'] as String,
    role: json['role'] as String,
    photo: json['photo'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'fcmToken': instance.fcmToken,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'photo': instance.photo,
    };
