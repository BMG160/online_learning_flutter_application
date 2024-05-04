// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentVO _$AssignmentVOFromJson(Map<String, dynamic> json) => AssignmentVO(
      json['assignment_id'] as String?,
      json['file_name'] as String?,
      json['file_path'] as String?,
      json['uploaded_date'] as String?,
      json['uploaded_by_id'] as String?,
      json['uploaded_by_name'] as String?,
      json['course_id'] as String?,
      json['teacher_comment'] as String?,
      json['student_mark'] as String?,
    );

Map<String, dynamic> _$AssignmentVOToJson(AssignmentVO instance) =>
    <String, dynamic>{
      'assignment_id': instance.assignmentID,
      'file_name': instance.fileName,
      'file_path': instance.filePath,
      'uploaded_date': instance.uploadedDate,
      'uploaded_by_id': instance.uploadedByID,
      'uploaded_by_name': instance.uploadedByName,
      'course_id': instance.courseID,
      'teacher_comment': instance.teacherComment,
      'student_mark': instance.studentMark,
    };
