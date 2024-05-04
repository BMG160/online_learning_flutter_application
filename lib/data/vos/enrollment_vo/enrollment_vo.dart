import 'package:json_annotation/json_annotation.dart';


part 'enrollment_vo.g.dart';

@JsonSerializable()
class EnrollmentVO{

  @JsonKey(name: 'enrollment_id')
  String? enrollmentID;

  @JsonKey(name: 'enroll_date')
  String? enrollDate;

  @JsonKey(name: 'student_id')
  String? studentID;

  @JsonKey(name: 'student_name')
  String? studentName;


  @JsonKey(name: 'profile')
  String? profile;

  @JsonKey(name: 'course_id')
  String? courseID;

  @JsonKey(name: 'course_name')
  String? courseName;

  @JsonKey(name: 'course_image')
  String courseImage;

  @JsonKey(name: 'teacher_id')
  String teacherID;


  EnrollmentVO(this.enrollmentID, this.enrollDate, this.studentID,
      this.studentName, this.profile, this.courseID, this.courseName, this. courseImage, this.teacherID);

  factory EnrollmentVO.fromJson(Map<String ,dynamic> json) => _$EnrollmentVOFromJson(json);

  Map<String, dynamic>toJson() => _$EnrollmentVOToJson(this);
}