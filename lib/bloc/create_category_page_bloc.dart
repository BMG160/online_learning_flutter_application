
import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/category_vo/category_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/teacher_home_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/successfull_feedback_snack_bar.dart';

class CreateCategoryPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  bool get isDispose => _dispose;

  TextEditingController nameController = TextEditingController();

  TextEditingController get getNameController => nameController;

  void createNewCategory(BuildContext context, TeacherVO? teacher) async{
    if(nameController.text.isEmpty){
      feedbackSnackBar(context, 'Please fill all field');
    }
    else{
      try{
        loadingDialog(context: context);
        await _apply.createNewCategory(CategoryVO(DateTime.now().microsecondsSinceEpoch.toString(), nameController.text));
        if(!context.mounted) return;
        Navigator.pop(context);
        successfulFeedbackSnackBar(context, "New category is created successfully.");
        context.navigateToNextScreenReplace(context, TeacherHomePage(teacher: teacher,));
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
    nameController.dispose();
  }
}