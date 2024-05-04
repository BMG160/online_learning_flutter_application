// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseVO _$CourseVOFromJson(Map<String, dynamic> json) => CourseVO(
      json['course_id'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      json['price'] as String?,
      json['photo'] as String?,
      json['duration'] as String?,
      json['start_date'] as String?,
      json['category_id'] as String?,
      json['teacher_id'] as String?,
      json['teacher_name'] as String?,
    );

Map<String, dynamic> _$CourseVOToJson(CourseVO instance) => <String, dynamic>{
      'course_id': instance.courseID,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'photo': instance.photo,
      'duration': instance.duration,
      'start_date': instance.startDate,
      'category_id': instance.categoryID,
      'teacher_id': instance.teacherID,
      'teacher_name': instance.teacherName,
    };
