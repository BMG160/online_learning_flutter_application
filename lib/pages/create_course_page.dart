import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/create_course_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/secondary_text_form_field.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';


class CreateCoursePage extends StatelessWidget {
  final String categoryID;
  final String categoryName;
  final String teacherID;
  final String teacherName;
  const CreateCoursePage({super.key, required this.categoryID, required this.categoryName, required this.teacherID, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateCoursePageBloc>(
      create: (_) => CreateCoursePageBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new, size: k25px, color: kWhite,)),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(k20px),
            child: Selector<CreateCoursePageBloc, TextEditingController>(
              selector: (_, bloc) => bloc.getTitleController,
              builder: (_, titleController, child) => Selector<CreateCoursePageBloc, TextEditingController>(
                selector: (_, bloc) => bloc.getDescriptionController,
                builder: (_, descriptionController, child) => Selector<CreateCoursePageBloc, TextEditingController>(
                  selector: (_, bloc) => bloc.getPriceController,
                  builder: (_, priceController, child) => Selector<CreateCoursePageBloc, File?>(
                    selector: (_, bloc) => bloc.getImage,
                    builder: (_, image, child) => Selector<CreateCoursePageBloc, TextEditingController>(
                      selector: (_, bloc) => bloc.getDurationController,
                      builder: (_, durationController, child) => Selector<CreateCoursePageBloc, TextEditingController>(
                        selector: (_, bloc) => bloc.getStartDateController,
                        builder: (_, startDateController, child) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: EasyTextWidget(text: 'Create New Course', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600)),
                            const VerticalSpacingWidget(h: k20px),
                            EasyTextWidget(text: 'Category: $categoryName', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.w600),
                            const VerticalSpacingWidget(h: k20px),
                            CourseImageView(image: image,),
                            const VerticalSpacingWidget(h: k20px),
                            EasyTextWidget(text: 'Course Title', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                            const VerticalSpacingWidget(h: k10px),
                            SecondaryTextFormField(controller: titleController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter course title.'),
                            const VerticalSpacingWidget(h: k10px),
                            EasyTextWidget(text: 'Course Description', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                            const VerticalSpacingWidget(h: k10px),
                            SecondaryTextFormField(controller: descriptionController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter course description'),
                            const VerticalSpacingWidget(h: k10px),
                            EasyTextWidget(text: 'Course Price', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                            const VerticalSpacingWidget(h: k10px),
                            SecondaryTextFormField(controller: priceController, textInputType: TextInputType.number, textInputAction: TextInputAction.next, hintText: 'Enter course price'),
                            const VerticalSpacingWidget(h: k10px),
                            EasyTextWidget(text: 'Course Duration', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                            const VerticalSpacingWidget(h: k10px),
                            SecondaryTextFormField(controller: durationController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Enter course duration'),
                            const VerticalSpacingWidget(h: k10px),
                            EasyTextWidget(text: 'Course Start Date', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                            const VerticalSpacingWidget(h: k10px),
                            StartDateView(startDateController: startDateController,),
                            const VerticalSpacingWidget(h: k30px),
                            ButtonView(categoryID: categoryID, teacherID: teacherID, teacherName: teacherName)
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
    );
  }
}

class CourseImageView extends StatelessWidget {
  final File? image;
  const CourseImageView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: k200px,
      child: GestureDetector(
        onTap: (){
          context.read<CreateCoursePageBloc>().showOptions(context);
        },
        child: image == null ? Stack(
          children: [
            Image.asset(kDefaultCourseImage, fit: BoxFit.cover,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: k200px,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  )
              ),
            ),
            Center(child: EasyTextWidget(text: 'Please Select Image For Your Course', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),)
          ],
        ) : Image.file(image!, fit: BoxFit.cover,)
      ),
    );
  }
}

class StartDateView extends StatelessWidget {
  final TextEditingController startDateController;
  const StartDateView({super.key, required this.startDateController});

  @override
  Widget build(BuildContext context) {
    return SecondaryTextFormField(controller: startDateController, textInputType: TextInputType.text, textInputAction: TextInputAction.done, hintText: 'Select Course Start Date', readOnly: true,
      onTap: (){
        context.read<CreateCoursePageBloc>().selectDate(context);
      },);
  }
}

class ButtonView extends StatelessWidget {
  final String categoryID;
  final String teacherID;
  final String teacherName;
  const ButtonView({super.key, required this.categoryID, required this.teacherID, required this.teacherName});

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
                  context.read<CreateCoursePageBloc>().createCourse(context, categoryID, teacherID, teacherName);
                },
                child: Text("CREATE", style: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kSecondaryColor), maximumSize: const MaterialStatePropertyAll(Size(k150px, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(k150px, 50.0))),
                onPressed: (){
                  
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


