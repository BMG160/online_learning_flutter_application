import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';

import '../data/vos/student_vo/student_vo.dart';

class ManagingStudentPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  List<StudentVO>? studentList;

  List<StudentVO>? get getStudentList => studentList;

  ManagingStudentPageBloc(){
    _apply.getStudentListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        studentList = event;
      } else {
        studentList = null;
      }
      notifyListeners();
    });
  }
}