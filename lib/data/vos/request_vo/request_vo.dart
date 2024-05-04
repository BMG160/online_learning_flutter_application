import 'package:json_annotation/json_annotation.dart';

part 'request_vo.g.dart';

@JsonSerializable()
class RequestVO{

  @JsonKey(name: 'request_id')
  String? requestID;

  @JsonKey(name: 'course_id')
  String? courseID;

  @JsonKey(name: 'course_image')
  String? courseImage;

  @JsonKey(name: 'course_name')
  String? courseName;

  @JsonKey(name: 'student_id')
  String? studentID;

  @JsonKey(name: 'student_profile')
  String? studentProfile;

  @JsonKey(name: 'student_name')
  String? studentName;

  @JsonKey(name: 'request_date')
  String? requestDate;

  @JsonKey(name: 'teacher_id')
  String? teacherID;

  RequestVO(this.requestID, this.courseID, this.courseImage, this.courseName,
      this.studentID, this.studentProfile, this.studentName, this.requestDate, this.teacherID);

  factory RequestVO.fromJson(Map<String, dynamic> json) => _$RequestVOFromJson(json);

  Map<String, dynamic> toJson() => _$RequestVOToJson(this);
}