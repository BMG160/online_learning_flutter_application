import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/category_vo/category_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/utils/extension.dart';

class TeacherHomePageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  int numberOfCourse = 0;

  int numberOfStudent = 0;

  List<CategoryVO>? categoryList;

  List<CourseVO>? courseList;

  bool get isDispose => _dispose;
  List<CategoryVO>? get getCategoryList => categoryList;
  List<CourseVO>? get getCourseList => courseList;
  int get getNumberOfCourse => numberOfCourse;
  int get getNumberOfStudent => numberOfStudent;

  TeacherHomePageBloc(String teacherID) {

    _apply.getCategoryListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        categoryList = event;
        _apply.getTeacherCourseListStream(teacherID, categoryList?.first.categoryID ?? '').listen((event) {
          if(event?.isNotEmpty ?? false){
            courseList = event;
          }
          else {
            courseList = [];
          }
        });
      }
      notifyListeners();
    });

    _apply.getCourseListByTeacherIDStream(teacherID).listen((event) {
      if(event?.isNotEmpty ?? false){
        numberOfCourse = event?.length ?? 0;
      }
      notifyListeners();
    });

    _apply.getEnrollmentByTeacherID(teacherID).listen((event) {
      if(event?.isNotEmpty ?? false){
        numberOfStudent = event?.length ?? 0;
      }
      print(numberOfStudent);
      notifyListeners();
    });
  }

  void changeCourse(String teacherID, String categoryID){
    courseList = [];
    _apply.getTeacherCourseListStream(teacherID, categoryID).listen((event) {
      if(event != null){
        courseList = event;
        notifyListeners();
      }
    });
  }

  void logout(BuildContext context) async{
    await _apply.logout();
    if(!context.mounted) return;
    Navigator.pop(context);
    context.navigateToNextScreenReplace(context, const LoginPage());
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