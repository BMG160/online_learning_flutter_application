import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';

import '../data/vos/request_vo/request_vo.dart';

class ManageEnrollRequestPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  List<RequestVO>? requestList;

  bool get isDispose => _dispose;
  List<RequestVO>? get getRequestList => requestList;

  ManageEnrollRequestPageBloc(){
    _apply.getEnrollRequestListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        requestList = event;
      } else {
        requestList = null;
      }
      notifyListeners();
    });
  }

  void approveRequest(RequestVO request){
    DateTime currentDate = DateTime.now();
    String enrollmentID = DateTime.now().millisecondsSinceEpoch.toString();
    print(request.teacherID);
    _apply.createEnrollment(EnrollmentVO(enrollmentID, "${currentDate.day}/${currentDate.month}/${currentDate.year}", request.studentID, request.studentName, request.studentProfile, request.courseID, request.courseName, request.courseImage ?? '', request.teacherID ?? ''));
    _apply.deleteEnrollRequestByRequestID(request.requestID ?? '');
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