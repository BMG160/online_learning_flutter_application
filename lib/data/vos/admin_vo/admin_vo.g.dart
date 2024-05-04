// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminVO _$AdminVOFromJson(Map<String, dynamic> json) => AdminVO(
      json['admin_id'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['email'] as String?,
      json['password'] as String?,
      json['phone_number'] as String?,
      json['profile'] as String?,
      json['account_registration_date'] as String?,
      json['address'] as String?,
      json['gender'] as String?,
      json['role'] as String?,
    );

Map<String, dynamic> _$AdminVOToJson(AdminVO instance) => <String, dynamic>{
      'admin_id': instance.adminID,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phone_number': instance.phoneNumber,
      'profile': instance.profile,
      'account_registration_date': instance.accountRegistrationDate,
      'address': instance.address,
      'gender': instance.gender,
      'role': instance.role,
    };
