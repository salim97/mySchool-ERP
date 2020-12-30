// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int,
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    auth_type: json['auth_type'] as String,
    password: json['password'] as String,
    token: json['token'] as String,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'auth_type': instance.auth_type,
      'password': instance.password,
      'token': instance.token,
      'role': instance.role,
    };
