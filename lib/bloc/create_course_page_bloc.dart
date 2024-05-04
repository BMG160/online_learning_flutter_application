import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/pages/teacher_home_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/successfull_feedback_snack_bar.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../widgets/easy_text_widget.dart';

class CreateCoursePageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();
  final picker = ImagePicker();

  bool _dispose = false;

  File? _image;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  bool get isDispose => _dispose;
  File? get getImage => _image;
  DateTime get getSelectedDate => _selectedDate;
  TextEditingController get getTitleController => titleController;
  TextEditingController get getDescriptionController => descriptionController;
  TextEditingController get getPriceController => priceController;
  TextEditingController get getDurationController => durationController;
  TextEditingController get getStartDateController => startDateController;

  CreateCoursePageBloc(){
    startDateController.text = "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
  }


  Future showOptions(BuildContext context) async{
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
                onPressed: (){
                  Navigator.of(context).pop(getImageFromGallery());
                },
                child: EasyTextWidget(text: 'Photo Gallery', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
            )
          ],
        )
    );
  }

  Future getImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2028)
    );
    if(picked!=null && picked != _selectedDate){
      _selectedDate = picked;
      startDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      notifyListeners();
    }
  }

  void createCourse(BuildContext context, String categoryID, String teacherID, String teacherName) async{
    String courseID = DateTime.now().millisecondsSinceEpoch.toString();
    loadingDialog(context: context);
    if(titleController.text.isEmpty || descriptionController.text.isEmpty || priceController.text.isEmpty || _image == null || durationController.text.isEmpty || startDateController.text.isEmpty){
      Navigator.pop(context);
      feedbackSnackBar(context, kEmptyFieldWarning);
    } else {
      try{
        await _apply.createNewTeacherCourse(CourseVO(courseID, titleController.text, descriptionController.text, priceController.text, _image?.path, durationController.text, startDateController.text, categoryID, teacherID, teacherName), teacherID, categoryID);
        await _apply.createNewCourse(CourseVO(courseID, titleController.text, descriptionController.text, priceController.text, _image?.path, durationController.text, startDateController.text,categoryID, teacherID, teacherName));
        if(!context.mounted) return;
        _apply.getTeacherByTeacherID(teacherID).then((value) {
          Navigator.pop(context);
          successfulFeedbackSnackBar(context, "New course created successfully");
          context.navigateToNextScreenReplace(context, TeacherHomePage(teacher: value));
        });
      } catch (e){
        Navigator.pop(context);
        feedbackSnackBar(context, e.toString());
      }
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
    descriptionController.dispose();
    priceController.dispose();
    durationController.dispose();
    startDateController.dispose();
  }
}