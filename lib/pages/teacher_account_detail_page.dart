import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/teacher_account_detail_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/teacher_registration_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

class TeacherAccountDetailPage extends StatelessWidget {
  final AdminVO? admin;
  final TeacherVO? teacher;
  const TeacherAccountDetailPage({super.key, this.admin, this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherAccountDetailPageBloc>(
      create: (_) => TeacherAccountDetailPageBloc(),
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
          actions: [
            IconButton(
              onPressed: (){
                context.navigateToNextScreenReplace(context, TeacherRegistrationPage(admin: admin, teacher: teacher,));
              },
              icon: Icon(Icons.edit, color: kWhite, size: k25px,),
            ),
            const HorizontalSpacingWidget(w: k10px)
          ],
        ),
        body: Hero(
            tag: 'Teacher Account Detail',
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(k100px),
                    child: Image.network(teacher?.profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
                      if(loadingProgress == null){
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        );
                      }
                    },),
                  ),
                ),
              ),
              const VerticalSpacingWidget(h: k20px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'First Name', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: k50px,
                    child: EasyTextWidget(text: teacher?.firstName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k10px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Last Name', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: k50px,
                    child: EasyTextWidget(text: teacher?.lastName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k10px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Email', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: k50px,
                    child: EasyTextWidget(text: teacher?.email ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k10px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Phone Number', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: k50px,
                    child: EasyTextWidget(text: teacher?.phoneNumber ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k10px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Address', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: k50px,
                    child: EasyTextWidget(text: teacher?.address ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k10px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Registration', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: k50px,
                    child: EasyTextWidget(text: teacher?.accountRegistrationDate ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k10px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Gender', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: k50px,
                    child: EasyTextWidget(text: teacher?.gender ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k20px),
              AccountDeleteButton(teacher: teacher,)
            ],
          ),
        )
        ),
      ),
    );
  }
}

class AccountDeleteButton extends StatelessWidget {
  final TeacherVO? teacher;
  const AccountDeleteButton({super.key, this.teacher});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.red), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
        onPressed: (){
          context.read<TeacherAccountDetailPageBloc>().deleteAccount(context, teacher?.teacherID ?? '');
        },
        child: Text("DELETE", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
    );
  }
}

