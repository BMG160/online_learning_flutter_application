
import 'dart:async';

import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';

abstract class FirebaseAuthAbst{
  Future registerNewAdmin (AdminVO newAdmin);

  Future registerNewTeacher (TeacherVO newTeacher);

  Future registerNewStudent (StudentVO newStudent, String verificationID, String smsCode);

  Future deleteUser();

  Future userLogin (String email, String password);

  bool isLogin();

  String getLoggedInUser();

  Future logout();
}