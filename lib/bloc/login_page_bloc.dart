
import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/pages/staff_dashboard.dart';
import 'package:myanmar_educational/pages/student_home_page.dart';
import 'package:myanmar_educational/pages/teacher_home_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/successfull_feedback_snack_bar.dart';

class LoginPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  bool _visibility = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isDispose => _dispose;
  bool get getVisibility => _visibility;

  TextEditingController get getEmailController => emailController;
  TextEditingController get getPasswordController => passwordController;

  void changePasswordVisibility(){
    _visibility = !_visibility;
    notifyListeners();
  }

  void clearFunction(){
    emailController.clear();
    passwordController.clear();
  }

  Future login(BuildContext context) async{
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      feedbackSnackBar(context, 'Please fill all fields');
    } else {
      loadingDialog(context: context);
      try{
        await _apply.login(emailController.text, passwordController.text);
        String userID = _apply.getLoggedInUser();
        _apply.getAdminByAdminID(userID).then((value) {
          if(value?.role == 'Manager' || value?.role == 'Staff'){
            if(!context.mounted) return;
            Navigator.pop(context);
            successfulFeedbackSnackBar(context, 'Successfully Login');
            context.navigateToNextScreenReplace(context, StaffDashboard(admin: value!,));
            clearFunction();
          } else {
            _apply.getTeacherByTeacherID(userID).then((value) {
              if(value?.userRole == 'Teacher'){
                if(!context.mounted) return;
                Navigator.pop(context);
                successfulFeedbackSnackBar(context, 'Successfully Login');
                context.navigateToNextScreenReplace(context, TeacherHomePage(teacher: value,));
                clearFunction();
              } else {
                _apply.getStudentByStudentID(userID).then((value) {
                  if(value?.userRole == 'Student'){
                    if(!context.mounted) return;
                    Navigator.pop(context);
                    successfulFeedbackSnackBar(context, 'Successfully Login');
                    context.navigateToNextScreenReplace(context, StudentHomePage(student: value,));
                    clearFunction();
                  }
                });
              }
            });
          }
        });
      } catch (e){
        if(!context.mounted) return;
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
    emailController.dispose();
    passwordController.dispose();
  }
}