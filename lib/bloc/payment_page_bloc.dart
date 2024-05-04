import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';

import '../data/vos/course_vo/course_vo.dart';
import '../data/vos/request_vo/request_vo.dart';
import '../data/vos/student_vo/student_vo.dart';

class PaymentPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  void createRequest(BuildContext context, StudentVO student, CourseVO course) async{
    DateTime currentDate = DateTime.now();
    String chatRoomID = '';

    if((student.studentID ?? '').substring(0,1).codeUnitAt(0) > (course.teacherID ?? '').substring(0,1).codeUnitAt(0)){
      chatRoomID = "${course.teacherID ?? ''}_${student.studentID ?? ''}";
    } else {
      chatRoomID = "${student.studentID ?? ''}_${course.teacherID ?? ''}";
    }
    print(course.teacherID);
    await _apply.uploadEnrollRequest(RequestVO(DateTime.now().millisecondsSinceEpoch.toString(), course.courseID, course.photo, course.title, student.studentID, student.profile, "${student.firstName} ${student.lastName}", "${currentDate.day}/${currentDate.month}/${currentDate.year}", course.teacherID));
    // await _apply.createEnrollment(EnrollmentVO(DateTime.now().millisecondsSinceEpoch.toString(), "${currentDate.day}/${currentDate.month}/${currentDate.year}", student.studentID, "${student.firstName} ${student.lastName}", student.profile, course.courseID, course.title, course.photo ?? ''));
    // if(!context.mounted) return;
  }
}