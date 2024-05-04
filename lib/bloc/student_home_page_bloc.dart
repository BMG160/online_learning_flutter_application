import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/enroll_student_course_detail_page.dart';
import 'package:myanmar_educational/pages/free_student_course_detial_page.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';

import '../data/vos/category_vo/category_vo.dart';
import '../data/vos/course_vo/course_vo.dart';

class StudentHomePageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  bool _filer = false;

  List<CategoryVO>? categoryList;

  List<CourseVO>? courseList;

  List<EnrollmentVO>? myCourseList;

  int _selectedIndex = 0;

  String? categoryName;

  bool get isDispose => _dispose;
  bool get isFilter => _filer;
  int get getSelectedIndex => _selectedIndex;
  List<CategoryVO>? get getCategoryList => categoryList;
  List<CourseVO>? get getCourseList => courseList;
  List<EnrollmentVO>? get getMyCourseList => myCourseList;
  String? get getCategoryName => categoryName;

  StudentHomePageBloc(String studentID){
    _apply.getCategoryListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        categoryList = event;
      }
      notifyListeners();
    });
    _apply.getCourseListStream().listen((event) {
      courseList = event;
      notifyListeners();
    });

    _apply.getEnrollmentByStudentID(studentID).listen((event) {
      if(event?.isNotEmpty ?? false){
        myCourseList = event;
      } else {
        myCourseList = null;
      }
      notifyListeners();
    });
  }

  void changeIndex(int i){
    _selectedIndex = i;
    notifyListeners();
  }

  void logout(BuildContext context){
    _apply.logout();
    Navigator.popUntil(context, ModalRoute.withName('/login'));
    context.navigateToNextScreenReplace(context, const LoginPage());
  }

  void filterCourse(String categoryID){
    _filer = true;
    _apply.getCourseListByCategoryIDStream(categoryID).listen((event) {
      if(event?.isNotEmpty ?? false){
        courseList = event;
      } else {
        courseList = null;
      }
      notifyListeners();
    });
  }

  void checkEnrollment(BuildContext context, StudentVO student, CourseVO course){
    try{
      _apply.getEnrollmentByStudentIDAndCourseID(student.studentID ?? '', course.courseID ?? '').listen((value) {
        if((value?.isNotEmpty ?? false)){
          String chatRoomID = '';

          if((student.studentID ?? '').substring(0,1).codeUnitAt(0) > (course.teacherID ?? '').substring(0,1).codeUnitAt(0)){
            chatRoomID = "${course.teacherID ?? ''}_${student.studentID ?? ''}";
          } else {
            chatRoomID = "${student.studentID ?? ''}_${course.teacherID ?? ''}";
          }
          context.navigateToNextScreenReplace(context, EnrollStudentCourseDetailPage(course: course, student: student, chatRoomID: chatRoomID, senderID: student.studentID ?? '',));
        } else {
          context.navigateToNextScreenReplace(context, FreeStudentCourseDetailPage(course: course, student: student,));
        }
      });
    } catch(e){
      if(!context.mounted) return;
      feedbackSnackBar(context, e.toString());
    }
  }

  void checkStudentEnrollment(BuildContext context, StudentVO student, String courseID)async{
    CourseVO? course ;
    await _apply.getCourseByCourseID(courseID).then((value) {
      course = value;
    });
    try{
      _apply.getEnrollmentByStudentIDAndCourseID(student.studentID ?? '', course?.courseID ?? '').listen((value) {
        if((value?.isNotEmpty ?? false)){
          String chatRoomID = '';

          if((student.studentID ?? '').substring(0,1).codeUnitAt(0) > (course?.teacherID ?? '').substring(0,1).codeUnitAt(0)){
            chatRoomID = "${course?.teacherID ?? ''}_${student.studentID ?? ''}";
          } else {
            chatRoomID = "${student.studentID ?? ''}_${course?.teacherID ?? ''}";
          }
          context.navigateToNextScreenReplace(context, EnrollStudentCourseDetailPage(course: course!, student: student, chatRoomID: chatRoomID, senderID: student.studentID ?? '',));
        } else {
          context.navigateToNextScreenReplace(context, FreeStudentCourseDetailPage(course: course!, student: student,));
        }
      });
    } catch(e){
      if(!context.mounted) return;
      feedbackSnackBar(context, e.toString());
    }
  }

  void unFilter(){
    _filer = false;
    _apply.getCourseListStream().listen((event) {
      courseList = event;
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if(!_dispose){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }
}

