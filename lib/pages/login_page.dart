import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/login_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/pages/student_registration_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/easy_text_form_field.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/dimens.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageBloc>(
      create: (_) => LoginPageBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: Image.asset(kMyanmarEducationalLogo, width: k25px, height: k25px,),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(top: k20px),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(kLoginLogo, width: k250px, height: k250px,),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: EasyTextWidget(text: 'By using our services you are agreeing to our', textColor: kSecondaryColor, textSize: k15px, fontWeight: FontWeight.w600)),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EasyTextWidget(text: 'Terms ', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
                        EasyTextWidget(text: 'and', textColor: kSecondaryColor, textSize: k15px, fontWeight: FontWeight.w600),
                        EasyTextWidget(text: ' Privacy Statement', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
                      ],
                    )
                  ),
                ),
                const VerticalSpacingWidget(h: k20px),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: k20px, top: k20px, right: k20px, bottom: 70),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(k20px), topLeft: Radius.circular(k20px))
                  ),
                  child: Selector<LoginPageBloc, TextEditingController>(
                    selector: (_, bloc) => bloc.getEmailController,
                    builder: (_, emailController, child) => Selector<LoginPageBloc, TextEditingController>(
                      selector: (_, bloc) => bloc.getPasswordController,
                      builder: (_, passwordController, child) => Selector<LoginPageBloc, bool>(
                        selector: (_, bloc) => bloc.getVisibility,
                        builder: (_, visibility, child) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: EasyTextWidget(text: 'LOGIN', textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w600),
                            ),
                            const VerticalSpacingWidget(h: k40px),
                            EasyTextWidget(text: 'Email', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.w300),
                            const VerticalSpacingWidget(h: k5px),
                            EasyTextFormField(controller: emailController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your email.'),
                            const VerticalSpacingWidget(h: k10px),
                            EasyTextWidget(text: 'Password', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.w300),
                            const VerticalSpacingWidget(h: k5px),
                            EasyTextFormField(obscureText: visibility, controller: passwordController, textInputType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, hintText: 'Enter your password.', suffixIcon: PasswordVisibilityWidget(visibility: visibility),),
                            const VerticalSpacingWidget(h: k25px),
                            const ButtonView(),
                            const VerticalSpacingWidget(h: k20px),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EasyTextWidget(text: "Doesn't have a student account? ", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                  GestureDetector(
                                    onTap: (){
                                      context.navigateToNextScreenReplace(context, const StudentRegistrationPage());
                                    },
                                    child: Text('CLICK HERE', style: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal, decoration: TextDecoration.underline, decorationColor: kWhite, fontStyle: FontStyle.italic)),),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
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
          context.read<LoginPageBloc>().changePasswordVisibility();
        },
        icon: Icon(
            visibility ? Icons.visibility : Icons.visibility_off,
          color:  kWhite,
        )
    );
  }
}

class ButtonView extends StatelessWidget {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kWhite), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
        onPressed: (){
          context.read<LoginPageBloc>().login(context);
        },
        child: Text("LOGIN", style: GoogleFonts.lato(textStyle: TextStyle(color: kPrimaryColor, fontSize: k15px, fontWeight: FontWeight.normal)),)
    );
  }
}

