import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/teacher_course_detail_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/successfull_feedback_snack_bar.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';
import '../data/apply/apply.dart';
import '../data/apply/apply_impl.dart';
import '../data/vos/video_vo/video_vo.dart';
import '../utils/feedback_snack_bar.dart';

class UploadSampleVideoPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  final picker = ImagePicker();

  File? _video;

  Uint8List? tb;

  final TextEditingController titleController = TextEditingController();

  bool get isDispose => _dispose;
  Uint8List? get getTB => tb;
  TextEditingController get getTitleController => titleController;

  Future getVideoFromGallery() async{
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if(pickedFile != null){
      _video = File(pickedFile.path);
      generateThumbnail(_video!);
      notifyListeners();
    }
  }

  Future generateThumbnail(File file) async{
    final thumbnailBytes = await VideoCompress.getByteThumbnail(file.path);
    tb = thumbnailBytes;
    notifyListeners();
  }

  void uploadVideo(BuildContext context, CourseVO course, TeacherVO? teacher) async{
    try{
      String videoID = DateTime.now().millisecondsSinceEpoch.toString();
      loadingDialog(context: context);
      await _apply.uploadSampleVideo(course.courseID ?? '', VideoVO(videoID, titleController.text, null, _video?.path, null));
      await _apply.uploadTeacherSampleVideo(course.teacherID ?? '', course.categoryID ?? '', course.courseID ?? '', VideoVO(videoID, titleController.text, null, _video?.path, null));
      if(!context.mounted) return;
      Navigator.pop(context);
      context.navigateToNextScreenReplace(context,TeacherCourseDetailPage(teacher: teacher, course: course));
      successfulFeedbackSnackBar(context, 'Done');
    } catch (e) {
      Navigator.pop(context);
      print(e);
      feedbackSnackBar(context, e.toString());
    }
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
    titleController.dispose();
  }
}