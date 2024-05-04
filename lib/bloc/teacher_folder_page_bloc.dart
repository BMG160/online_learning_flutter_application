import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/assignment_vo/assignment_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';

import '../data/vos/file_vo/file_vo.dart';

class TeacherFolderPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  FilePickerResult? pickedFile;

  List<FileVO>? lectureFileList;
  List<FileVO>? assignmentFileList;
  List<AssignmentVO>? studentFileList;

  bool clickedLecture = false;
  bool clickedAssignment = false;
  bool clickedStudentAssignment = false;

  TextEditingController commentController = TextEditingController();
  TextEditingController markController = TextEditingController();

  bool get isDispose => _dispose;
  List<FileVO>? get getLectureFileList => lectureFileList;
  List<FileVO>? get getAssignmentFileList => assignmentFileList;
  List<AssignmentVO>? get getStudentFileList => studentFileList;
  bool get isLectureClicked => clickedLecture;
  bool get isAssignmentClicked => clickedAssignment;
  bool get isStudentAssignmentClicked => clickedStudentAssignment;
  TextEditingController get getCommentController => commentController;
  TextEditingController get getMarkController => markController;

  TeacherFolderPageBloc(String teacherID, String categoryID, String courseID){
    _apply.getTeacherLectureFileStream(teacherID, categoryID, courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        lectureFileList = event;
      } else {
        lectureFileList = null;
      }
      notifyListeners();
    });

    _apply.getTeacherAssignmentFileStream(teacherID, categoryID, courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        assignmentFileList = event;
      } else {
        assignmentFileList = null;
      }
      notifyListeners();
    });

    _apply.getAssignmentByCourseID(courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        studentFileList = event;
      } else {
        studentFileList = null;
      }
      print(studentFileList);
      notifyListeners();
    });
  }

  Future<void> pickAndUploadLectureFile(CourseVO course, BuildContext context) async{
    DateTime currentDate = DateTime.now();
    pickedFile = await FilePicker.platform.pickFiles();
    if(pickedFile != null){
      String fileID = DateTime.now().millisecondsSinceEpoch.toString();
      File file = File(pickedFile?.files.single.path ?? '');
      try{
        if(!context.mounted) return;
        loadingDialog(context: context);
        await _apply.uploadLectureFile(course.courseID ?? '', FileVO(fileID, file.path.split('/').last, file.path, "${currentDate.day}/${currentDate.month}/${currentDate.year}", course.teacherID, course.teacherName));
        await _apply.uploadTeacherLectureFile(course.teacherID ?? '', course.categoryID ?? '', course.courseID ?? '', FileVO(fileID, file.path.split('/').last, file.path, "${currentDate.day}/${currentDate.month}/${currentDate.year}", course.teacherID, course.teacherName));
        if(!context.mounted) return;
        Navigator.pop(context);
        feedbackSnackBar(context, "DONE");
      } catch (e){
        if(!context.mounted) return;
        Navigator.pop(context);
        feedbackSnackBar(context, e.toString());
      }
    }
  }

  Future<void> pickAndUploadAssignmentFile(CourseVO course, BuildContext context) async{
    DateTime currentDate = DateTime.now();
    pickedFile = await FilePicker.platform.pickFiles();
    if(pickedFile != null){
      File file = File(pickedFile?.files.single.path ?? '');
      String fileID = DateTime.now().millisecondsSinceEpoch.toString();
      try{
        if(!context.mounted) return;
        loadingDialog(context: context);
        await _apply.uploadAssignmentFile(course.courseID ?? '', FileVO(fileID, file.path.split('/').last, file.path, "${currentDate.day}/${currentDate.month}/${currentDate.year}", course.teacherID, course.teacherName));
        await _apply.uploadTeacherAssignmentFile(course.teacherID ?? '', course.categoryID ?? '', course.courseID ?? '', FileVO(fileID, file.path.split('/').last, file.path, "${currentDate.day}/${currentDate.month}/${currentDate.year}", course.teacherID, course.teacherName));
        if(!context.mounted) return;
        Navigator.pop(context);
        feedbackSnackBar(context, "DONE");
      } catch (e){
        if(!context.mounted) return;
        Navigator.pop(context);
        feedbackSnackBar(context, e.toString());
      }
    }
  }

  void commentAssignment(AssignmentVO assignment){
    print(markController.text);
    _apply.createStudentAssignment(AssignmentVO(assignment.assignmentID, assignment.fileName, assignment.filePath, assignment.uploadedDate, assignment.uploadedByID, assignment.uploadedByName, assignment.courseID, commentController.text, markController.text), null);
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