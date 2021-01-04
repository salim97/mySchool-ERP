// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) {
  return StudentModel(
    id: json['_id'] as String,
    parent_id: json['parent_id'] as String,
    gender: json['gender'] as String,
    date_of_birth: json['date_of_birth'] as String,
    blood_group: json['blood_group'] as String,
    phone: json['phone'] as String,
    street_address: json['street_address'] as String,
    city_name: json['city_name'] as String,
    country: json['country'] as String,
    pin_code: json['pin_code'] as String,
    joining_date: json['joining_date'] as String,
    leaving_date: json['leaving_date'] as String,
    current_position: json['current_position'] as String,
    rollNo: json['rollNo'] as String,
    working_hours: json['working_hours'] as String,
  );
}

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'parent_id': instance.parent_id,
      'gender': instance.gender,
      'date_of_birth': instance.date_of_birth,
      'blood_group': instance.blood_group,
      'phone': instance.phone,
      'street_address': instance.street_address,
      'city_name': instance.city_name,
      'country': instance.country,
      'pin_code': instance.pin_code,
      'joining_date': instance.joining_date,
      'leaving_date': instance.leaving_date,
      'current_position': instance.current_position,
      'rollNo': instance.rollNo,
      'working_hours': instance.working_hours,
    };
