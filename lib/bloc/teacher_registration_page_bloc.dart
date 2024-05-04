import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/successfull_feedback_snack_bar.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../widgets/easy_text_widget.dart';

class TeacherRegistrationPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();
  final picker = ImagePicker();

  bool _dispose = false;
  bool _visibility = true;

  File? profile;
  String genderSelection = '';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController registrationDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool get isDispose => _dispose;
  bool get getVisibility => _visibility;
  File? get getProfile => profile;
  String get getGenderSelection => genderSelection;
  TextEditingController get getFirstNameController => firstNameController;
  TextEditingController get getLastNameController => lastNameController;
  TextEditingController get getEmailController => emailController;
  TextEditingController get getPasswordController => passwordController;
  TextEditingController get getPhoneNumberController => phoneNumberController;
  TextEditingController get getRegistrationDateController => registrationDateController;
  TextEditingController get getAddressController => addressController;

  TeacherRegistrationPageBloc(TeacherVO? teacher){
    if(teacher != null){
      profile = File(teacher.profile ?? '');
      firstNameController.text = teacher.firstName ?? '';
      lastNameController.text = teacher.lastName ?? '';
      emailController.text = teacher.email ?? '';
      passwordController.text = teacher.password ?? '';
      phoneNumberController.text = teacher.phoneNumber ?? '';
      registrationDateController.text = teacher.accountRegistrationDate ?? '';
      addressController.text = teacher.address ?? '';
      genderSelection = teacher.gender ?? '';
    } else {
      DateTime currentDate = DateTime.now();
      registrationDateController.text = "${currentDate.day}/${currentDate.month}/${currentDate.year}";
      phoneNumberController.text = "+959";
    }
  }



  void changePasswordVisibility(){
    _visibility = !_visibility;
    notifyListeners();
  }

  void changeGenderSelection(String gender){
    genderSelection = gender;
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
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future registerNewTeacher(BuildContext context, String adminID, String adminName) async{
    if(firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || phoneNumberController.text.isEmpty || registrationDateController.text.isEmpty || addressController.text.isEmpty){
      feedbackSnackBar(context, 'Please fill all fields');
    } else {
      loadingDialog(context: context);
      try{
        await _apply.registerNewTeacher(TeacherVO('', firstNameController.text, lastNameController.text, emailController.text, passwordController.text, phoneNumberController.text, profile?.path, registrationDateController.text, addressController.text, genderSelection, adminID, adminName, 'Teacher'));
        if(!context.mounted) return;
        Navigator.pop(context);
        clearFunction();
        successfulFeedbackSnackBar(context, 'Successfully created');
      } catch (e){
        Navigator.pop(context);
        feedbackSnackBar(context, e.toString());
      }
    }
  }

  Future updateTeacherInformation(BuildContext context, String teacherID, String profile, String createdByAdminID, String createdByAdminName) async{
    loadingDialog(context: context);
    await _apply.createNewTeacher(TeacherVO(teacherID, firstNameController.text, lastNameController.text, emailController.text, passwordController.text, phoneNumberController.text, profile, registrationDateController.text, addressController.text, genderSelection, createdByAdminID, createdByAdminName, 'Teacher'), null, null, null, null, null, null, null, null, null, null, null, null, null);
    if(!context.mounted) return;
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void clearFunction(){
    DateTime currentDate = DateTime.now();
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    phoneNumberController.text = '+959';
    registrationDateController.text = '${currentDate.day}/${currentDate.month}/${currentDate.year}';
    addressController.text = '';
    genderSelection = '';
    profile = null;
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    registrationDateController.dispose();
    addressController.dispose();
  }
}