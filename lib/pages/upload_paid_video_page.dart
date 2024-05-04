import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/upload_paid_video_page_bloc.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_form_field.dart';
import '../widgets/easy_text_widget.dart';
import '../widgets/vertical_spacing_widget.dart';

class UploadPaidVideoPage extends StatelessWidget {
  final TeacherVO? teacher;
  final CourseVO course;
  const UploadPaidVideoPage({super.key,required this.teacher, required this.course,});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UploadPaidVideoPageBloc>(
      create: (_) => UploadPaidVideoPageBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: kWhite,
              size: k25px,
            ),
          ),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(k20px),
              child: Selector<UploadPaidVideoPageBloc, TextEditingController>(
                selector: (_, bloc) => bloc.getTitleController,
                builder: (_, titleController, child) => Selector<UploadPaidVideoPageBloc, Uint8List?>(
                  selector: (_, bloc) => bloc.getTB,
                  builder: (_, thumbnail, child) => Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(k20px),
                      color: kPrimaryColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EasyTextWidget(text: 'Video Title', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                          const VerticalSpacingWidget(h: k15px),
                          EasyTextFormField(controller: titleController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter video title'),
                          const VerticalSpacingWidget(h: k20px),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: k200px,
                              child: (thumbnail==null) ? Center(child: EasyTextWidget(text: 'No video has been selected', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),) :
                              Image.memory(thumbnail)
                          ),
                          const VerticalSpacingWidget(h: k20px),
                          ButtonView(course: course, teacher:  teacher,)
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}

class ButtonView extends StatelessWidget {
  final CourseVO course;
  final TeacherVO? teacher;
  const ButtonView({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kWhite), maximumSize: const MaterialStatePropertyAll(Size(150.0, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(150.0, 50.0))),
              onPressed: (){
                context.read<UploadPaidVideoPageBloc>().getVideoFromGallery();
              },
              child: Text("Select Video", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.normal)),)
          ),
          ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kWhite), maximumSize: const MaterialStatePropertyAll(Size(150.0, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(150.0, 50.0))),
              onPressed: (){
                context.read<UploadPaidVideoPageBloc>().uploadVideo(context, course, teacher);
              },
              child: Text("Upload Video", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.normal)),)
          )
        ],
      ),
    );
  }
}
