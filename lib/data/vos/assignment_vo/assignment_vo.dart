import 'package:json_annotation/json_annotation.dart';

part 'assignment_vo.g.dart';

@JsonSerializable()
class AssignmentVO{

  @JsonKey(name: 'assignment_id')
  String? assignmentID;

  @JsonKey(name: 'file_name')
  String? fileName;

  @JsonKey(name: 'file_path')
  String? filePath;

  @JsonKey(name: 'uploaded_date')
  String? uploadedDate;

  @JsonKey(name: 'uploaded_by_id')
  String? uploadedByID;

  @JsonKey(name: 'uploaded_by_name')
  String? uploadedByName;

  @JsonKey(name: 'course_id')
  String? courseID;

  @JsonKey(name: 'teacher_comment')
  String? teacherComment;

  @JsonKey(name: 'student_mark')
  String? studentMark;

  AssignmentVO(
      this.assignmentID,
      this.fileName,
      this.filePath,
      this.uploadedDate,
      this.uploadedByID,
      this.uploadedByName,
      this.courseID,
      this.teacherComment,
      this.studentMark,
      );

  factory AssignmentVO.fromJson(Map<String, dynamic> json) => _$AssignmentVOFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentVOToJson(this);
}