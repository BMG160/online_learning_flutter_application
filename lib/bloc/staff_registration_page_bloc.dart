import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/feedback_snack_bar.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/successfull_feedback_snack_bar.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';

import '../constant/dimens.dart';

class StaffRegistrationPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();
  final picker = ImagePicker();

  bool _dispose = false;

  File? profile;

  String genderSelection = '';

  bool visibility = true;

  List<String> roleList = ['Manager', 'Staff'];

   String _selectedRole = 'Manager';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController registrationDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  bool get isDispose => _dispose;
  File? get getProfile => profile;
  String get getGenderSelection => genderSelection;
  bool get getVisibility => visibility;
  List<String> get getRoleList => roleList;
  TextEditingController get getFirstNameController => firstNameController;
  TextEditingController get getLastNameController => lastNameController;
  TextEditingController get getEmailController => emailController;
  TextEditingController get getPasswordController => passwordController;
  TextEditingController get getPhoneNumberController => phoneNumberController;
  TextEditingController get getRegistrationDateController => registrationDateController;
  TextEditingController get getAddressController => addressController;
  String get getSelectedRole => _selectedRole;

  StaffRegistrationPageBloc(){
    DateTime currentDate = DateTime.now();
    registrationDateController.text = "${currentDate.day}/${currentDate.month}/${currentDate.year}";
    phoneNumberController.text = "+959";
  }

  void changePasswordVisibility(){
    visibility = !visibility;
    notifyListeners();
  }

  void changeGenderSelection(String gender) {
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

  void setSelectedRole(String role){
    _selectedRole = role;
    notifyListeners();
  }

  Future createNewAdmin(BuildContext context) async{
    if(firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || phoneNumberController.text.isEmpty || registrationDateController.text.isEmpty || addressController.text.isEmpty || profile == null ){
      feedbackSnackBar(context, 'Please filled all field');
    } else {
      loadingDialog(context: context);
      try {
        await _apply.registerNewAdmin(AdminVO('', firstNameController.text, lastNameController.text, emailController.text, passwordController.text, phoneNumberController.text, profile?.path, registrationDateController.text, addressController.text, genderSelection, _selectedRole));
        if(!context.mounted) return;
        clearFunction();
        successfulFeedbackSnackBar(context, "Successfully created.");
        Navigator.pop(context);
      } catch (e){
        Navigator.pop(context);
        feedbackSnackBar(context, e.toString());
      }
    }
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
    roleController.text = '';
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
    roleController.dispose();
  }
}