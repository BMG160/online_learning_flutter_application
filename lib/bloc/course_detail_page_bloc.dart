
import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/request_vo/request_vo.dart';


class CourseDetailPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  List<RequestVO>? requestList;

  bool get isDispose => _dispose;
  List<RequestVO>? get getRequestList => requestList;

  CourseDetailPageBloc(String courseID, String studentID){
    _apply.getEnrollRequestListByCourseIDAndStudentID(courseID, studentID).listen((event) {
      if(event?.isNotEmpty ?? false){
        requestList = event;
      } else {
        requestList = null;
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