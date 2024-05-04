import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/assignment_vo/assignment_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';

import '../data/vos/file_vo/file_vo.dart';

class FolderPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  bool get isDispose => _dispose;

  FilePickerResult? pickedFile;

  List<FileVO>? lectureFileList;
  List<FileVO>? assignmentFileList;
  List<AssignmentVO>? studentAssignmentList;

  bool clickedLecture = false;
  bool clickedAssignment = false;
  bool clickedStudentAssignment = false;

  List<FileVO>? get getLectureFileList => lectureFileList;
  List<FileVO>? get getAssignmentFileList => assignmentFileList;
  List<AssignmentVO>? get getStudentAssignmentList => studentAssignmentList;
  bool get isLectureClicked => clickedLecture;
  bool get isAssignmentClicked => clickedAssignment;
  bool get isStudentAssignmentClicked => clickedStudentAssignment;

  FolderPageBloc(String courseID, String studentID){
    _apply.getLectureFileStream(courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        lectureFileList = event;
      } else {
        lectureFileList = null;
      }
      notifyListeners();
    });

    _apply.getAssignmentFileStream(courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        assignmentFileList = event;
      } else {
        assignmentFileList = null;
      }
      notifyListeners();
    });

    _apply.getAssignmentByStudentIDAndCourseID(studentID, courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        studentAssignmentList = event;
      } else {
        studentAssignmentList = null;
      }
    });
  }

  void uploadAssignment(BuildContext context, StudentVO student, String courseID, String? comment, String? mark) async{
    DateTime currentDate = DateTime.now();
    pickedFile = await FilePicker.platform.pickFiles();
    if(pickedFile != null){
      File file = File(pickedFile?.files.single.path ?? '');
      try{
        if(!context.mounted) return;
        loadingDialog(context: context);
        await _apply.createStudentAssignment(null,AssignmentVO(DateTime.now().millisecondsSinceEpoch.toString(), file.path.split('/').last, file.path, "${currentDate.day}/${currentDate.month}/${currentDate.year}", student.studentID, "${student.firstName} ${student.lastName}", courseID, comment, mark));
        if(!context.mounted) return;
        Navigator.pop(context);
        feedbackSnackBar(context, 'DONE');
      } catch (e){
        if(!context.mounted) return;
        Navigator.pop(context);
        feedbackSnackBar(context, e.toString());
      }
    }
  }

  void setLectureClicked(){
    clickedLecture = !clickedLecture;
    notifyListeners();
  }

  void setAssignmentClicked(){
    clickedAssignment = !clickedAssignment;
    notifyListeners();
  }

  void setStudentAssignmentClicked(){
    clickedStudentAssignment = !clickedStudentAssignment;
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