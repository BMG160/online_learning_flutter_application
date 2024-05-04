import 'package:json_annotation/json_annotation.dart';

part 'admin_vo.g.dart';

@JsonSerializable()
class AdminVO{

  @JsonKey(name: 'admin_id')
  String? adminID;

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

  @JsonKey(name: 'role')
  String? role;

  AdminVO(
      this.adminID,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber,
      this.profile,
      this.accountRegistrationDate,
      this.address,
      this.gender,
      this.role);

  factory AdminVO.fromJson(Map<String, dynamic> json) => _$AdminVOFromJson(json);

  Map<String, dynamic> toJson() => _$AdminVOToJson(this);
}