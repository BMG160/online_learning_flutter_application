import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/pages/teacher_home_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';

import '../data/vos/teacher_vo/teacher_vo.dart';

class TeacherCourseDetailPageBloc extends ChangeNotifier{

  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  final picker = ImagePicker();

  Uint8List? tb;

  int _selectedIndex = 0;

  bool get isDispose => _dispose;
  int get getSelectedIndex => _selectedIndex;

  final TextEditingController titleController = TextEditingController();

  Uint8List? get getTB => tb;
  TextEditingController get getTitleController => titleController;

  void changeIndex(int i){
    _selectedIndex = i;
    notifyListeners();
  }

  void deleteCourse(BuildContext context, String teacherID, String categoryID, String courseID, TeacherVO? teacher) async{
    loadingDialog(context: context);
    await _apply.deleteCourseFromTeacher(teacherID, categoryID, courseID);
    await _apply.deleteCourse(courseID);
    if(!context.mounted) return;
    Navigator.pop(context);
    Navigator.popUntil(context, ModalRoute.withName('/teacher_home'));
    context.navigateToNextScreenReplace(context, TeacherHomePage(teacher: teacher));
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