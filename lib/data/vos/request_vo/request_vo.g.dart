// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestVO _$RequestVOFromJson(Map<String, dynamic> json) => RequestVO(
      json['request_id'] as String?,
      json['course_id'] as String?,
      json['course_image'] as String?,
      json['course_name'] as String?,
      json['student_id'] as String?,
      json['student_profile'] as String?,
      json['student_name'] as String?,
      json['request_date'] as String?,
      json['teacher_id'] as String?,
    );

Map<String, dynamic> _$RequestVOToJson(RequestVO instance) => <String, dynamic>{
      'request_id': instance.requestID,
      'course_id': instance.courseID,
      'course_image': instance.courseImage,
      'course_name': instance.courseName,
      'student_id': instance.studentID,
      'student_profile': instance.studentProfile,
      'student_name': instance.studentName,
      'request_date': instance.requestDate,
      'teacher_id': instance.teacherID,
    };
