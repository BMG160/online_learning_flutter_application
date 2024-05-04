import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/payment_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/easy_text_widget.dart';

class PaymentPage extends StatelessWidget {
  final CourseVO course;
  final StudentVO student;
  const PaymentPage({super.key, required this.course, required this.student});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentPageBloc>(
      create: (_) => PaymentPageBloc(),
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
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k25px, fontWeight: FontWeight.w900),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.7,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                  child: Image.asset(kPaymentImage, fit: BoxFit.fill,),
                ),
              ),
              const VerticalSpacingWidget(h: k20px),
              PaymentButton(course: course, student: student)
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final CourseVO course;
  final StudentVO student;
  const PaymentButton({super.key, required this.course, required this.student});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kSecondaryColor), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
        onPressed: (){
          context.read<PaymentPageBloc>().createRequest(context, student, course);
          Navigator.pop(context);
        },
        child: Text("Done", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kPrimaryColor, fontSize: k15px, fontWeight: FontWeight.normal)),)
    );
  }
}

