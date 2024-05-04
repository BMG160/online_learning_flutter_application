import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';

import '../data/vos/teacher_vo/teacher_vo.dart';

class ManagingTeacherPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  bool get isDispose => _dispose;

  List<TeacherVO>? teacherList;

  List<TeacherVO>? get getTeacherList => teacherList;

  ManagingTeacherPageBloc(){
    _apply.getTeacherListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        teacherList = event;
      }
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