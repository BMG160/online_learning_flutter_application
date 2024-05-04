import 'package:json_annotation/json_annotation.dart';

part 'teacher_vo.g.dart';

@JsonSerializable()
class TeacherVO{

  @JsonKey(name: 'teacher_id')
  String? teacherID;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'profile')
  String? profile;

  @JsonKey(name: 'account_registration_date')
  String? accountRegistrationDate;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'create_by_admin_id')
  String? createdByAdminID;

  @JsonKey(name: 'created_by_admin_name')
  String? createdByAdminName;

  @JsonKey(name: 'user_role')
  String? userRole;

  TeacherVO(
      this.teacherID,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber,
      this.profile,
      this.accountRegistrationDate,
      this.address,
      this.gender,
      this.createdByAdminID,
      this.createdByAdminName,
      this.userRole);

  factory TeacherVO.fromJson(Map<String, dynamic> json) => _$TeacherVOFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherVOToJson(this);
}