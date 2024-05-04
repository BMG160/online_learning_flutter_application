// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentVO _$StudentVOFromJson(Map<String, dynamic> json) => StudentVO(
      json['student_id'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['email'] as String?,
      json['password'] as String?,
      json['phone_number'] as String?,
      json['profile'] as String?,
      json['account_registration_date'] as String?,
      json['user_role'] as String?,
    );

Map<String, dynamic> _$StudentVOToJson(StudentVO instance) => <String, dynamic>{
      'student_id': instance.studentID,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phone_number': instance.phoneNumber,
      'profile': instance.profile,
      'account_registration_date': instance.accountRegistrationDate,
      'user_role': instance.userRole,
    };
