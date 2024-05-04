import 'package:json_annotation/json_annotation.dart';

part 'student_vo.g.dart';

@JsonSerializable()
class StudentVO{

  @JsonKey(name: 'student_id')
  String? studentID;

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

  @JsonKey(name: 'user_role')
  String? userRole;

  StudentVO(
      this.studentID,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber,
      this.profile,
      this.accountRegistrationDate,
      this.userRole);

  factory StudentVO.fromJson(Map<String, dynamic> json) => _$StudentVOFromJson(json);

  Map<String, dynamic>toJson() => _$StudentVOToJson(this);
}