import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';

import '../data/vos/teacher_vo/teacher_vo.dart';

class TeacherAccountDetailPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  TeacherVO? teacher;

  void deleteAccount(BuildContext context, String teacherID) async{
    loadingDialog(context: context);
    await _apply.deleteTeacher(teacherID);
    if(!context.mounted) return;
    Navigator.popUntil(context, ModalRoute.withName('/login'));
    context.navigateToNextScreenReplace(context, const LoginPage());
  }
}