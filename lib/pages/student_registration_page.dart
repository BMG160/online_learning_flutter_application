import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/student_registration_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/widgets/easy_text_form_field.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_widget.dart';
import '../widgets/horizontal_spacing_widget.dart';
import '../widgets/secondary_text_form_field.dart';

class StudentRegistrationPage extends StatelessWidget {
  const StudentRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentRegistrationPageBloc>(
      create: (_) => StudentRegistrationPageBloc(),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: k25px,),
          ),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: k20px),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.10, left: k20px, right: k20px, bottom: k20px),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(k20px), topLeft: Radius.circular(k20px))
                  ),
                  child: Selector<StudentRegistrationPageBloc, TextEditingController>(
                    selector: (_, bloc) => bloc.getFirstNameController,
                    builder: (_, firstNameController, child) => Selector<StudentRegistrationPageBloc, TextEditingController>(
                      selector: (_, bloc) => bloc.getLastNameController,
                      builder: (_, lastNameController, child) => Selector<StudentRegistrationPageBloc, TextEditingController>(
                        selector: (_, bloc) => bloc.getEmailController,
                        builder: (_, emailController, child) => Selector<StudentRegistrationPageBloc, TextEditingController>(
                          selector: (_, bloc) => bloc.getPasswordController,
                          builder: (_, passwordController, child) => Selector<StudentRegistrationPageBloc, bool>(
                            selector: (_, bloc) => bloc.getVisibility,
                            builder: (_, visibility, child) => Selector<StudentRegistrationPageBloc, TextEditingController>(
                              selector: (_, bloc) => bloc.getPhoneNumberController,
                              builder: (_, phoneNumberController, child) => Selector<StudentRegistrationPageBloc, TextEditingController>(
                                selector: (_, bloc) => bloc.getRegistrationDateController,
                                builder: (_, registrationController, child) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: EasyTextWidget(text: 'Student Registration', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
                                    ),
                                    const VerticalSpacingWidget(h: k30px),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            EasyTextWidget(text: 'First Name', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                            const VerticalSpacingWidget(h: k5px),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.435,
                                              child: SecondaryTextFormField(controller: firstNameController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter your first name here.'),
                                            )
                                          ],
                                        ),
                                        const HorizontalSpacingWidget(w: k10px),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            EasyTextWidget(text: 'Last Name', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                            const VerticalSpacingWidget(h: k5px),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.435,
                                              child: SecondaryTextFormField(controller: lastNameController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter your last name here.'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const VerticalSpacingWidget(h: k10px),
                                    EasyTextWidget(text: 'Email', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                    const VerticalSpacingWidget(h: k5px),
                                    SecondaryTextFormField(controller: emailController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your email address here.'),
                                    const VerticalSpacingWidget(h: k10px),
                                    EasyTextWidget(text: 'Password', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                    const VerticalSpacingWidget(h: k5px),
                                    SecondaryTextFormField(obscureText: visibility, controller: passwordController, textInputType: TextInputType.visiblePassword, textInputAction: TextInputAction.next, hintText: 'Enter your password here.', suffixIcon: PasswordVisibilityWidget(visibility: visibility),),
                                    const VerticalSpacingWidget(h: k10px),
                                    EasyTextWidget(text: 'Phone Number', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                    const VerticalSpacingWidget(h: k5px),
                                    SecondaryTextFormField(controller: phoneNumberController, textInputType: TextInputType.phone, textInputAction: TextInputAction.next, hintText: 'Enter your phone number with country code at the start'),
                                    const VerticalSpacingWidget(h: k10px),
                                    EasyTextWidget(text: 'Account Registration Date', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                    const VerticalSpacingWidget(h: k5px),
                                    SecondaryTextFormField(controller: registrationController, textInputType: TextInputType.datetime, textInputAction: TextInputAction.done, hintText: 'Enter your account registration date here.', readOnly: true,),
                                    const VerticalSpacingWidget(h: k25px),
                                    const ButtonView()
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
                const ProfileView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordVisibilityWidget extends StatelessWidget {
  final bool visibility;
  const PasswordVisibilityWidget({super.key, required this.visibility});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<StudentRegistrationPageBloc>().changeVisibility();
        },
        icon: Icon(visibility ? Icons.visibility : Icons.visibility_off)
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
                  context.read<StudentRegistrationPageBloc>().createNewStudent(context);
                },
                child: Text("Register", style: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kSecondaryColor), maximumSize: const MaterialStatePropertyAll(Size(k150px, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(k150px, 50.0))),
                onPressed: (){

                },
                child: Text("Clear", style: GoogleFonts.lato(textStyle: TextStyle(color: kPrimaryColor, fontSize: k15px, fontWeight: FontWeight.normal)),)
            ),
          ],
        ),
        const VerticalSpacingWidget(h: k20px),
      ],
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<StudentRegistrationPageBloc, File?>(
      selector: (_, bloc) => bloc.getImage,
      builder: (_, profile, child) => Center(
        child: GestureDetector(
            onTap: (){
              context.read<StudentRegistrationPageBloc>().showOptions(context);
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

