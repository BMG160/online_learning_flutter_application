import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/folder_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/data/vos/assignment_vo/assignment_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/file_vo/file_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/easy_text_widget.dart';
import '../widgets/horizontal_spacing_widget.dart';

class FolderPage extends StatelessWidget {
  final StudentVO student;
  final CourseVO course;
  const FolderPage({super.key, required this.course, required this.student});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FolderPageBloc>(
      create: (_) => FolderPageBloc(course.courseID ?? '', student.studentID ?? ''),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: k50px,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: kPrimaryColor, width: 0.5))
                      ),
                      child: const LectureFolderView(),
                    ),
                    Selector<FolderPageBloc, bool>(
                        selector: (_, bloc) => bloc.isLectureClicked,
                        builder: (_, isClicked, child) => (isClicked) ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: k300px,
                          color: kPrimaryColor,
                          child: Selector<FolderPageBloc, List<FileVO>?>(
                            selector: (_, bloc) => bloc.getLectureFileList,
                            builder: (_, lectureFileList, child) => (lectureFileList == null) ? Center(child: EasyTextWidget(text: "There is no lecture file", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),) : ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    launchUrl(Uri.parse(lectureFileList?[index].filePath ?? ''));
                                  },
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      height: k30px,
                                      padding: const EdgeInsets.symmetric(horizontal: k20px),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: kWhite, width: 0.5))
                                      ),
                                      child: EasyTextWidget(text: lectureFileList?[index].fileName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const VerticalSpacingWidget(h: k15px),
                              itemCount: lectureFileList?.length ?? 0,
                            )
                          ),
                        ) : const SizedBox()
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: k50px,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: kPrimaryColor, width: 0.5))
                      ),
                      child: const AssignmentFolderView(),
                    ),
                    Selector<FolderPageBloc, bool>(
                        selector: (_, bloc) => bloc.isAssignmentClicked,
                        builder: (_, isClicked, child) => (isClicked) ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: k300px,
                          color: kPrimaryColor,
                          child: Selector<FolderPageBloc, List<FileVO>?>(
                            selector: (_, bloc) => bloc.getAssignmentFileList,
                            builder: (_, assignmentFileList, child) => (assignmentFileList == null) ?
                            Center(child: EasyTextWidget(text: 'There is no assignment upload', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),) :
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    launchUrl(Uri.parse(assignmentFileList[index].filePath ?? ''));
                                  },
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      height: k30px,
                                      padding: const EdgeInsets.symmetric(horizontal: k20px),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: kWhite, width: 0.5))
                                      ),
                                      child: EasyTextWidget(text: assignmentFileList?[index].fileName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const VerticalSpacingWidget(h: k15px),
                              itemCount: assignmentFileList.length ?? 0,
                            )
                          ),
                        ) : const SizedBox()
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: k50px,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: kPrimaryColor, width: 0.5))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const StudentAssignmentFolderView(),
                          UploadStudentAssignmentButtonView(student: student, courseID: course.courseID ?? '')
                        ],
                      ),
                    ),
                    Selector<FolderPageBloc, bool>(
                        selector: (_, bloc) => bloc.isStudentAssignmentClicked,
                        builder: (_, isClicked, child) => (isClicked) ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: k400px,
                          padding: const EdgeInsets.symmetric(horizontal: k20px),
                          color: kPrimaryColor,
                          child: Selector<FolderPageBloc, List<AssignmentVO>?>(
                            selector: (_, bloc) => bloc.getStudentAssignmentList,
                            builder: (_, studentAssignmentList, child) => (studentAssignmentList == null) ?
                            Center(
                              child: EasyTextWidget(text: 'There is no assignment file', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                            ) : ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: k200px,
                                  padding: const EdgeInsets.all(k20px),
                                  decoration: BoxDecoration(
                                      color: kTertiaryColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(k20px))
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: GestureDetector(
                                          onTap: (){
                                            launchUrl(Uri.parse(studentAssignmentList?[index].filePath ?? ''));
                                          },
                                          child: Container(
                                              height: k30px,
                                              decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(color: kPrimaryColor, width: 0.5))
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  EasyTextWidget(text: "File Name: ${studentAssignmentList?[index].fileName ?? ''}", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                                  const HorizontalSpacingWidget(w: k10px),
                                                  EasyTextWidget(text: "|", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                                  const HorizontalSpacingWidget(w: k10px),
                                                  EasyTextWidget(text: "Uploaded By: ${studentAssignmentList?[index].uploadedByName ?? ''}", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                                  const HorizontalSpacingWidget(w: k10px),
                                                  EasyTextWidget(text: "|", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                                  const HorizontalSpacingWidget(w: k10px),
                                                  EasyTextWidget(text: "Uploaded Date: ${studentAssignmentList?[index].uploadedDate ?? ''}", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      const VerticalSpacingWidget(h: k20px),
                                      (studentAssignmentList?[index].studentMark == null) ?
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: k50px,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              EasyTextWidget(text: 'Your Mark: ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                            ],
                                          )
                                      ) :
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: k50px,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              EasyTextWidget(text: 'Your Mark: ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                              EasyTextWidget(text: studentAssignmentList?[index].studentMark ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                            ],
                                          )
                                      ),
                                      (studentAssignmentList?[index].teacherComment == null) ?
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: k50px,
                                        child: EasyTextWidget(text: 'Comment: ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                      ) :
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              EasyTextWidget(text: 'Comment: ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                              EasyTextWidget(text: studentAssignmentList?[index].teacherComment ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const VerticalSpacingWidget(h: k15px),
                              itemCount: studentAssignmentList?.length ?? 0,
                            )
                          ),
                        ) : const SizedBox()
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LectureFolderView extends StatelessWidget {
  const LectureFolderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<FolderPageBloc>().setLectureClicked();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.folder, size: k25px, color: kPrimaryColor,),
          const HorizontalSpacingWidget(w: k5px),
          EasyTextWidget(text: 'lecture_folder/', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}

class AssignmentFolderView extends StatelessWidget {
  const AssignmentFolderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<FolderPageBloc>().setAssignmentClicked();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.folder, size: k25px, color: kPrimaryColor,),
          const HorizontalSpacingWidget(w: k5px),
          EasyTextWidget(text: 'assignment_folder/', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}

class StudentAssignmentFolderView extends StatelessWidget {
  const StudentAssignmentFolderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<FolderPageBloc>().setStudentAssignmentClicked();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.folder, size: k25px, color: kPrimaryColor,),
          const HorizontalSpacingWidget(w: k5px),
          EasyTextWidget(text: 'your_assignment_folder/', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}

class UploadStudentAssignmentButtonView extends StatelessWidget {
  final StudentVO student;
  final String courseID;
  const UploadStudentAssignmentButtonView({super.key, required this.student, required this.courseID});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        context.read<FolderPageBloc>().uploadAssignment(context, student, courseID, null, null);
      },
      icon: Icon(Icons.add, color: kPrimaryColor, size: k25px,),
    );
  }
}



