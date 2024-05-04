import 'package:json_annotation/json_annotation.dart';

part 'course_vo.g.dart';

@JsonSerializable()
class CourseVO{

  @JsonKey(name: 'course_id')
  String? courseID;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'price')
  String? price;

  @JsonKey(name: 'photo')
  String? photo;

  @JsonKey(name: 'duration')
  String? duration;

  @JsonKey(name: 'start_date')
  String? startDate;

  @JsonKey(name: 'category_id')
  String? categoryID;

  @JsonKey(name: 'teacher_id')
  String? teacherID;

  @JsonKey(name: 'teacher_name')
  String? teacherName;

  CourseVO(this.courseID, this.title, this.description, this.price, this.photo,
      this.duration, this.startDate, this.categoryID, this.teacherID, this.teacherName);

  factory CourseVO.fromJson(Map<String, dynamic> json) => _$CourseVOFromJson(json);

  Map<String, dynamic>toJson() => _$CourseVOToJson(this);
}