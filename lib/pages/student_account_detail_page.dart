import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/student_account_detail_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

class StudentAccountDetailPage extends StatelessWidget {
  final StudentVO? student;
  final AdminVO? admin;
  const StudentAccountDetailPage({super.key, this.student, this.admin});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentAccountDetailPageBloc>(

      create: (_) => StudentAccountDetailPageBloc(),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: kWhite, size: k25px,),
          ),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpacingWidget(h: k20px),
              Center(
                child: SizedBox(
                  width: k150px,
                  height: k150px,
                  child: ClipOval(
                    child: Image.network(student?.profile ?? '', fit: BoxFit.fill, loadingBuilder: (context, child, loadingProgress){
                      if(loadingProgress == null){
                          return child;
                      } else {
                        return CircularProgressIndicator(color: kWhite,);
                      }
                    },),
                  ),
                ),
              ),
              const VerticalSpacingWidget(h: k25px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k150px,
                    height: k50px,
                    child: EasyTextWidget(text: 'First Name', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.41,
                    height: k50px,
                    child: EasyTextWidget(text: student?.firstName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k150px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Last Name', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.41,
                    height: k50px,
                    child: EasyTextWidget(text: student?.lastName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k150px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Email', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.41,
                    height: k50px,
                    child: EasyTextWidget(text: student?.email ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k150px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Phone Number', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.41,
                    height: k50px,
                    child: EasyTextWidget(text: student?.phoneNumber ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k150px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Registration Date', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.41,
                    height: k50px,
                    child: EasyTextWidget(text: student?.accountRegistrationDate ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: k150px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Role', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.41,
                    height: k50px,
                    child: EasyTextWidget(text: student?.userRole ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const VerticalSpacingWidget(h: k20px),
              (admin == null) ? StudentAccountDeleteButton(studentID:  student?.studentID ?? '',) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class StudentAccountDeleteButton extends StatelessWidget {
  final String studentID;
  const StudentAccountDeleteButton({super.key, required this.studentID});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.red), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
        onPressed: (){

          context.read<StudentAccountDetailPageBloc>().deleteAccount(context, studentID);
        },
        child: Text("DELETE", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
    );
  }
}

