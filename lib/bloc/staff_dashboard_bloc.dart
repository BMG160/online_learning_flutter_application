import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/request_vo/request_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import '../data/vos/admin_vo/admin_vo.dart';

class StaffDashboardBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();
  AdminVO? admin;

  bool _dispose = false;

  PopUpMenuItemList? selectedMenu;


  List<TeacherVO>? teacherList;
  List<StudentVO>? studentList;
  List<AdminVO>? adminList;
  List<CourseVO>? courseList;
  List<EnrollmentVO>? enrollmentList;
  List<RequestVO>? requestList;

  bool get isDispose => _dispose;
  AdminVO? get getAdmin => admin;
  List<TeacherVO>? get getTeacherList => teacherList;
  List<StudentVO>? get getStudentList => studentList;
  List<AdminVO>? get getAdminList => adminList;
  List<CourseVO>? get getCourseList => courseList;
  List<EnrollmentVO>? get getEnrollmentList => enrollmentList;
  List<RequestVO>? get getRequestList => requestList;
  PopUpMenuItemList? get getSelectedMenu => selectedMenu;

  StaffDashboardBloc(){
    _apply.getAdminByAdminID(_apply.getLoggedInUser()).then((value) {
      if(value != null){
        admin = value;
      }
      notifyListeners();
    });

    _apply.getAdminListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        adminList = event;
      }
      notifyListeners();
    });

    _apply.getTeacherListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        teacherList = event;
      }
      notifyListeners();
    });
    _apply.getStudentListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        studentList = event;
      }
      notifyListeners();
    });

    _apply.getAllEnrollmentStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        enrollmentList = event;
      }
      notifyListeners();
    });

    _apply.getCourseListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        courseList = event;
      }
      notifyListeners();
    });

    _apply.getEnrollRequestListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        requestList = event;
      } else {
        requestList = null;
      }
      notifyListeners();
    });
  }

  void logout(BuildContext context) async{
   await _apply.logout();
   if(!context.mounted) return;
   Navigator.popUntil(context, ModalRoute.withName('/login'));
   context.navigateToNextScreenReplace(context, const LoginPage());
  }

  void setMenu(PopUpMenuItemList item) {
    selectedMenu = item;
    notifyListeners();
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
enum PopUpMenuItemList { Teacher, Student, Pending, Register_Teacher, Register_Admin }
