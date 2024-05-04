// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherVO _$TeacherVOFromJson(Map<String, dynamic> json) => TeacherVO(
      json['teacher_id'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['email'] as String?,
      json['password'] as String?,
      json['phone_number'] as String?,
      json['profile'] as String?,
      json['account_registration_date'] as String?,
      json['address'] as String?,
      json['gender'] as String?,
      json['create_by_admin_id'] as String?,
      json['created_by_admin_name'] as String?,
      json['user_role'] as String?,
    );

Map<String, dynamic> _$TeacherVOToJson(TeacherVO instance) => <String, dynamic>{
      'teacher_id': instance.teacherID,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phone_number': instance.phoneNumber,
      'profile': instance.profile,
      'account_registration_date': instance.accountRegistrationDate,
      'address': instance.address,
      'gender': instance.gender,
      'create_by_admin_id': instance.createdByAdminID,
      'created_by_admin_name': instance.createdByAdminName,
      'user_role': instance.userRole,
    };
