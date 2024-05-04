import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/staff_registration_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';
import 'package:myanmar_educational/widgets/password_visibility_widget.dart';
import 'package:myanmar_educational/widgets/secondary_text_form_field.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

class AdminRegistrationPage extends StatelessWidget {
  const AdminRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StaffRegistrationPageBloc>(
        create: (_) => StaffRegistrationPageBloc(),
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: k25px,),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.10, left: k20px, right: k20px, bottom: k20px),
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(k20px), topRight: Radius.circular(k20px))
                    ),
                    child: Selector<StaffRegistrationPageBloc, TextEditingController>(
                      selector: (_, bloc) => bloc.getFirstNameController,
                      builder: (_, firstNameController, child) => Selector<StaffRegistrationPageBloc, TextEditingController>(
                        selector: (_, bloc) => bloc.getLastNameController,
                        builder: (_, lastNameController, child) => Selector<StaffRegistrationPageBloc, TextEditingController>(
                          selector: (_, bloc) => bloc.getEmailController,
                          builder: (_, emailController, child) => Selector<StaffRegistrationPageBloc, bool>(
                            selector: (_, bloc) => bloc.getVisibility,
                            builder: (_, visibility, child) => Selector<StaffRegistrationPageBloc, TextEditingController>(
                              selector: (_, bloc) => bloc.getPasswordController,
                              builder: (_, passwordController, child) => Selector<StaffRegistrationPageBloc, TextEditingController>(
                                selector: (_, bloc) => bloc.getPhoneNumberController,
                                builder: (_, phoneNumberController, child) => Selector<StaffRegistrationPageBloc, File?>(
                                  selector: (_, bloc) => bloc.getProfile,
                                  builder: (_, profile, child) => Selector<StaffRegistrationPageBloc, TextEditingController>(
                                    selector: (_, bloc) => bloc.getRegistrationDateController,
                                    builder: (_, registrationDateController, child) => Selector<StaffRegistrationPageBloc, TextEditingController>(
                                      selector: (_, bloc) => bloc.getAddressController,
                                      builder: (_, addressController, child) => Selector<StaffRegistrationPageBloc, String>(
                                        selector: (_, bloc) => bloc.getGenderSelection,
                                        builder: (_, genderSelection, child) => Selector<StaffRegistrationPageBloc, List<String>>(
                                          selector: (_, bloc) => bloc.getRoleList,
                                          builder: (_, roleList, child) => Selector<StaffRegistrationPageBloc, String>(
                                            selector: (_, bloc) => bloc.getSelectedRole,
                                            builder: (_, role, child) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: EasyTextWidget(text: 'Staff Registration', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
                                                ),
                                                const VerticalSpacingWidget(h: k30px),
                                                ////First name and Last name text field
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        EasyTextWidget(text: 'First Name', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.w300),
                                                        const VerticalSpacingWidget(h: k5px),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width*0.435,
                                                          child: SecondaryTextFormField(controller: firstNameController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter your first name.'),
                                                        )
                                                      ],
                                                    ),
                                                    const HorizontalSpacingWidget(w: k10px),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        EasyTextWidget(text: 'Last Name', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.w300),
                                                        const VerticalSpacingWidget(h: k5px),
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width*0.435,
                                                          child: SecondaryTextFormField(controller: lastNameController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter your last name.'),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const VerticalSpacingWidget(h: k10px),
                                                EasyTextWidget(text: 'Email', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.w300),
                                                const VerticalSpacingWidget(h: k5px),
                                                SecondaryTextFormField(controller: emailController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your email address.'),
                                                const VerticalSpacingWidget(h: k10px),
                                                EasyTextWidget(text: 'Password', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.w300),
                                                const VerticalSpacingWidget(h: k5px),
                                                SecondaryTextFormField(obscureText:visibility, controller: passwordController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your password.', suffixIcon: PasswordVisibilityWidget(visibility: visibility),),
                                                const VerticalSpacingWidget(h: k10px),
                                                EasyTextWidget(text: 'Phone Number', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.w300),
                                                const VerticalSpacingWidget(h: k5px),
                                                SecondaryTextFormField(controller: phoneNumberController, textInputType: TextInputType.phone, textInputAction: TextInputAction.next, hintText: 'Enter your phone number.'),
                                                const VerticalSpacingWidget(h: k10px),
                                                EasyTextWidget(text: 'Account Registration Date', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.w300),
                                                const VerticalSpacingWidget(h: k5px),
                                                SecondaryTextFormField(controller: registrationDateController, textInputType: TextInputType.datetime, textInputAction: TextInputAction.next, hintText: 'Enter your account registration date', readOnly: true,),
                                                const VerticalSpacingWidget(h: k10px),
                                                EasyTextWidget(text: 'Address', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.w300),
                                                const VerticalSpacingWidget(h: k5px),
                                                SecondaryTextFormField(controller: addressController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter your address.'),
                                                const VerticalSpacingWidget(h: k10px),
                                                EasyTextWidget(text: 'Gender', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.w300),
                                                const VerticalSpacingWidget(h: k5px),
                                                Center(child: GenderView(gender: genderSelection),),
                                                const VerticalSpacingWidget(h: k10px),
                                                EasyTextWidget(text: 'Role', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.w300),
                                                const VerticalSpacingWidget(h: k5px),
                                                RoleView(role: role, roleList: roleList,),
                                                const VerticalSpacingWidget(h: k20px),
                                                const ButtonView(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ),
                const ProfileView()
              ],
            ),
          ),
        )
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<StaffRegistrationPageBloc, File?>(
      selector: (_, bloc) => bloc.getProfile,
      builder: (_, profile, child) => Center(
        child: GestureDetector(
          onTap: (){
            context.read<StaffRegistrationPageBloc>().showOptions(context);
          },
          child: profile == null ? Container(
              width: k250px,
              height: k250px,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.transparent, kBlack],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  )
              ),
              child: Stack(
                children: [
                  Image.asset(kDefaultProfileImage, fit: BoxFit.fill,),
                  Center(child: EasyTextWidget(text: 'Select Your Profile', textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w600),)
                ],
              )
          ) : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacingWidget(h: MediaQuery.of(context).size.height*0.05),
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(125),
                  child: Image.file(profile, fit: BoxFit.cover,),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}


class GenderView extends StatelessWidget {
  final String gender;
  const GenderView({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio<String>(
          value: "Male",
          groupValue: gender,
          toggleable: true,
          activeColor: kPrimaryColor,
          hoverColor: kWhite,
          onChanged: (value) {
            context.read<StaffRegistrationPageBloc>().changeGenderSelection(value.toString());
          },
        ),
        const SizedBox(
          width: 5.0,
        ),
        EasyTextWidget(text: 'Male', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.normal),
        const SizedBox(
          width: 20.0,
        ),
        Radio(
            value: "Female",
            groupValue: gender,
            toggleable: true,
            activeColor: kPrimaryColor,
            hoverColor: kWhite,
            onChanged: (value) {
              context.read<StaffRegistrationPageBloc>().changeGenderSelection(value.toString());
            }
        ),
        const SizedBox(
          width: 5.0,
        ),
        EasyTextWidget(text: 'Female', textColor: kPrimaryColor, textSize: 15, fontWeight: FontWeight.normal),
      ],
    );
  }
}

class RoleView extends StatelessWidget {
  final String role;
  final List<String> roleList;
  const RoleView({super.key, required this.role, required this.roleList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: k50px,
      padding: const EdgeInsets.symmetric(horizontal: k20px),
      decoration: BoxDecoration(
        color: kWhite,
        border: Border.all(color: kPrimaryColor, width: 1.0),
        borderRadius:const BorderRadius.all(Radius.circular(k10px))
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: role,
            items: roleList.map((String role) {
              return DropdownMenuItem(value:role, child: EasyTextWidget(text: role, textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal));
            }).toList(),
            onChanged: (String? selectedValue){
              context.read<StaffRegistrationPageBloc>().setSelectedRole(selectedValue!);
            },
            isExpanded: true,
            iconSize: k30px,
          )
      ),
    );
  }
}


class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kPrimaryColor), maximumSize: const MaterialStatePropertyAll(Size(k150px, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(k150px, 50.0))),
                onPressed: (){
                  context.read<StaffRegistrationPageBloc>().createNewAdmin(context);
                },
                child: Text("REGISTER", style: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kSecondaryColor), maximumSize: const MaterialStatePropertyAll(Size(k150px, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(k150px, 50.0))),
                onPressed: (){
                  context.read<StaffRegistrationPageBloc>().clearFunction();
                },
                child: Text("CLEAR", style: GoogleFonts.lato(textStyle: TextStyle(color: kPrimaryColor, fontSize: k15px, fontWeight: FontWeight.normal)),)
            ),
          ],
        ),
        const VerticalSpacingWidget(h: k20px),
      ],
    );
  }
}


