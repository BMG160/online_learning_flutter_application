import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/course_detail_page_bloc.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/request_vo/request_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/payment_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../widgets/easy_text_widget.dart';
import '../widgets/vertical_spacing_widget.dart';

class CourseDetailPage extends StatelessWidget {
  final StudentVO student;
  final CourseVO course;
  const CourseDetailPage({super.key, required this.course, required this.student});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CourseDetailPageBloc>(
      create: (_) => CourseDetailPageBloc(course.courseID ?? '', student.studentID ?? ''),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: k20px, vertical: k10px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: EasyTextWidget(text: 'Course Information', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
              ),
              const VerticalSpacingWidget(h: k30px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Title', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k20px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: k50px,
                    child: EasyTextWidget(text: course.title ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Price', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k20px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: k50px,
                    child: EasyTextWidget(text: "${course.price ?? ''} MMK", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Duration', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k20px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: k50px,
                    child: EasyTextWidget(text: course.duration ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Start Date', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k20px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: k50px,
                    child: EasyTextWidget(text: course.startDate ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: k100px,
                    height: k50px,
                    child: EasyTextWidget(text: 'Teacher', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k20px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: k50px,
                    child: EasyTextWidget(text: course.teacherName ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: k100px,
                    child: EasyTextWidget(text: 'Description', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k20px,
                    child: EasyTextWidget(text: '-', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k200px,
                    child: EasyTextWidget(text: course.description ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k20px),
              EnrollButton(student: student, course: course)
            ],
          ),
        ),
      ),
    );
  }
}

class EnrollButton extends StatelessWidget {
  final StudentVO student;
  final CourseVO course;
  const EnrollButton({super.key, required this.student, required this.course});

  @override
  Widget build(BuildContext context) {
    return Selector<CourseDetailPageBloc, List<RequestVO>?>(
      selector: (_, bloc) => bloc.getRequestList,
      builder: (_, requestList, child) => (requestList == null) ? ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kPrimaryColor), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
          onPressed: (){
            context.navigateToNextScreenReplace(context, PaymentPage(course: course, student: student));
          },
          child: Text("ENROLL", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
      ) : ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kPrimaryColor), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
          onPressed: (){
          },
          child: Text("PENDING...", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
      ),
    );
  }
}

