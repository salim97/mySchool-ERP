// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_table.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTableModel _$TimeTableModelFromJson(Map<String, dynamic> json) {
  return TimeTableModel(
    id: json['_id'] as String,
    createdAt: json['createdAt'] as String,
  )
    ..groupid = GroupModel.fromJson(json['groupid'] as Map<String, dynamic>)
    ..sectionid =
        SectionModel.fromJson(json['sectionid'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TimeTableModelToJson(TimeTableModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'groupid': instance.groupid,
      'sectionid': instance.sectionid,
    };
