// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) {
  return TeacherModel(
    id: json['_id'] as String,
    gender: json['gender'] as String,
    name: json['name'] as String,
    date_of_birth: json['date_of_birth'] as String,
    blood_group: json['blood_group'] as String,
    phone: json['phone'] as String,
    qualification: json['qualification'] as String,
    street_address: json['street_address'] as String,
    city_name: json['city_name'] as String,
    country: json['country'] as String,
    pin_code: json['pin_code'] as String,
    joining_date: json['joining_date'] as String,
    leaving_date: json['leaving_date'] as String,
    current_position: json['current_position'] as String,
    employee_code: json['employee_code'] as String,
    working_hours: json['working_hours'] as String,
    subjects_handling: json['subjects_handling'] as String,
    incharge_class: json['incharge_class'] as String,
  );
}

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'gender': instance.gender,
      'name': instance.name,
      'date_of_birth': instance.date_of_birth,
      'blood_group': instance.blood_group,
      'phone': instance.phone,
      'qualification': instance.qualification,
      'subjects_handling': instance.subjects_handling,
      'incharge_class': instance.incharge_class,
      'street_address': instance.street_address,
      'city_name': instance.city_name,
      'country': instance.country,
      'pin_code': instance.pin_code,
      'joining_date': instance.joining_date,
      'leaving_date': instance.leaving_date,
      'current_position': instance.current_position,
      'employee_code': instance.employee_code,
      'working_hours': instance.working_hours,
    };
