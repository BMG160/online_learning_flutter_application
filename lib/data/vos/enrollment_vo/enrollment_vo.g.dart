// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollmentVO _$EnrollmentVOFromJson(Map<String, dynamic> json) => EnrollmentVO(
      json['enrollment_id'] as String?,
      json['enroll_date'] as String?,
      json['student_id'] as String?,
      json['student_name'] as String?,
      json['profile'] as String?,
      json['course_id'] as String?,
      json['course_name'] as String?,
      json['course_image'] as String,
      json['teacher_id'] as String,
    );

Map<String, dynamic> _$EnrollmentVOToJson(EnrollmentVO instance) =>
    <String, dynamic>{
      'enrollment_id': instance.enrollmentID,
      'enroll_date': instance.enrollDate,
      'student_id': instance.studentID,
      'student_name': instance.studentName,
      'profile': instance.profile,
      'course_id': instance.courseID,
      'course_name': instance.courseName,
      'course_image': instance.courseImage,
      'teacher_id': instance.teacherID,
    };
