import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/show_opt_dialog.dart';
import 'package:myanmar_educational/utils/successfull_feedback_snack_bar.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';

class StudentRegistrationPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _dispose = false;

  File? _image;

  final picker = ImagePicker();

  bool _visibility = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController registrationDateController = TextEditingController();
  
  final TextEditingController optCodeController = TextEditingController();

  bool get isDispose => _dispose;
  File? get getImage => _image;
  bool get getVisibility => _visibility;

  TextEditingController get getFirstNameController => firstNameController;
  TextEditingController get getLastNameController => lastNameController;
  TextEditingController get getEmailController => emailController;
  TextEditingController get getPasswordController => passwordController;
  TextEditingController get getPhoneNumberController => phoneNumberController;
  TextEditingController get getRegistrationDateController => registrationDateController;
  
  StudentRegistrationPageBloc(){
    phoneNumberController.text = "+959";
    DateTime currentDate = DateTime.now();
    registrationDateController.text = "${currentDate.day}/${currentDate.month}/${currentDate.year}";
  }
  
  void createNewStudent(BuildContext context) async{
    if(_image == null || firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || phoneNumberController.text.isEmpty || registrationDateController.text.isEmpty){
      feedbackSnackBar(context, 'Please fill all the fields');
    } else {
      try{
        await _auth.verifyPhoneNumber(
            phoneNumber: phoneNumberController.text,
            timeout: const Duration(seconds: 120),
            verificationCompleted: (PhoneAuthCredential credential){},
            verificationFailed: (FirebaseAuthException e){},
            codeSent: (String verificationID, int? resendToken){
              showOptDialog(
                  context: context,
                  codeController: optCodeController,
                  onPressed: ()async{
                    loadingDialog(context: context);
                    await _apply.registerNewStudent(StudentVO('', firstNameController.text, lastNameController.text, emailController.text, passwordController.text, phoneNumberController.text, _image?.path, registrationDateController.text, 'Student'), verificationID, optCodeController.text);
                    if(!context.mounted) return;
                    Navigator.pop(context);
                    successfulFeedbackSnackBar(context, 'Successfully Created');
                    context.navigateToNextScreenReplace(context, const LoginPage());
                  }
              );
            },
            codeAutoRetrievalTimeout: (String verificationID){}
        );
      } on FirebaseAuthException {
        if(!context.mounted) return;
        feedbackSnackBar(context, 'ERROR!');
      }
    }
  }

  void changeVisibility(){
    _visibility = !_visibility;
    notifyListeners();
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
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, );
    if(pickedFile != null){
      _image = File(pickedFile.path);
      notifyListeners();
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    registrationDateController.dispose();
  }

}