
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/teacher_chat_page_bloc.dart';
import 'package:myanmar_educational/bloc/teacher_folder_page_bloc.dart';
import 'package:myanmar_educational/bloc/teacher_sample_video_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/assignment_vo/assignment_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/file_vo/file_vo.dart';
import 'package:myanmar_educational/data/vos/video_vo/video_vo.dart';
import 'package:myanmar_educational/bloc/teacher_paid_video_page_bloc.dart';
import 'package:myanmar_educational/pages/upload_paid_video_page.dart';
import 'package:myanmar_educational/pages/upload_sample_video_page.dart';
import 'package:myanmar_educational/pages/video_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/utils/loading_dialog.dart';
import 'package:myanmar_educational/utils/show_mark_comment_dialog.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/teacher_course_detail_page_bloc.dart';
import '../data/vos/teacher_vo/teacher_vo.dart';

class TeacherCourseDetailPage extends StatelessWidget {
  final TeacherVO? teacher;
  final CourseVO course;
  const TeacherCourseDetailPage({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CourseDetailPage(course: course, teacher:  teacher,),
      TeacherSampleVideoPage(course: course, teacher: teacher,),
      TeacherPaidVideoPage(course: course, teacher: teacher,),
      TeacherCourseFolderPage(course: course),
      TeacherChatPage(teacher: teacher, course: course)
    ];
    return ChangeNotifierProvider<TeacherCourseDetailPageBloc>(
      create: (_) => TeacherCourseDetailPageBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kWhite,
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: k200px,
                  flexibleSpace: FlexibleSpaceBar(
                    background: (course.photo==null) ? Image.asset(kDefaultCourseImage) : Image.network(course.photo ?? '', fit: BoxFit.fill,)
                  ),
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: k25px,),
                  ),
                )
              ];
            },
            body: Selector<TeacherCourseDetailPageBloc, int>(
              selector: (_, bloc) => bloc.getSelectedIndex,
              builder: (_, index, child) => pages[index],
            ),
        ),
        bottomNavigationBar: const BottomNavigationView(),
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final CourseVO course;
  final TeacherVO? teacher;
  const CourseDetailPage({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherCourseDetailPageBloc>(
      create: (_) => TeacherCourseDetailPageBloc(),
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
                    width: MediaQuery.of(context).size.width*0.6,
                    child: EasyTextWidget(text: course.description ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const VerticalSpacingWidget(h: k20px),
              DeleteCourseButton(teacherID: course.teacherID ?? '', categoryID: course.categoryID ?? '', courseID: course.courseID ?? '', teacher: teacher,)
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteCourseButton extends StatelessWidget {
  final String teacherID;
  final String categoryID;
  final String courseID;
  final TeacherVO? teacher;
  const DeleteCourseButton({super.key, required this.teacherID, required this.categoryID, required this.courseID, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.red), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
        onPressed: (){
          context.read<TeacherCourseDetailPageBloc>().deleteCourse(context, teacherID, categoryID, courseID, teacher);
        },
        child: Text("Delete Course", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: 15, fontWeight: FontWeight.normal)),)
    );
  }
}


class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TeacherCourseDetailPageBloc, int>(
      selector: (_, bloc) => bloc.getSelectedIndex,
      builder: (_, selectedIndex, child) => BottomNavigationBar(
          backgroundColor: kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: kWhite,
          unselectedItemColor: kSecondaryColor,
          onTap: (index){
            context.read<TeacherCourseDetailPageBloc>().changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.details),
                label: 'Detail'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.money_off),
                label: 'Sample Video'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.paid),
                label: 'Paid Video'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder),
                label: 'Course Folder'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Students'
            )
          ]
      ),
    );
  }
}


class TeacherSampleVideoPage extends StatelessWidget {
  final CourseVO course;
  final TeacherVO? teacher;
  const TeacherSampleVideoPage({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherSampleVideoPageBloc>(
      create: (_) => TeacherSampleVideoPageBloc(course.teacherID ?? '', course.categoryID ?? '', course.courseID ?? ''),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: k10px),
          child: Selector<TeacherSampleVideoPageBloc, List<VideoVO>?>(
            selector: (_, bloc) => bloc.getSampleVideoList,
            builder: (_, sampleVideoList, child) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacingWidget(h: k15px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EasyTextWidget(text: 'Sample Videos', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.normal),
                    UploadSampleVideoButtonView(course: course, teacher: teacher,)
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.55,
                  child: (sampleVideoList == null) ? Center(child: EasyTextWidget(text: 'There is no video.', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),)
                      : ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: (){
                          context.navigateToNextScreenReplace(context, VideoPage(videoPath: sampleVideoList[index].videoPath ?? ''));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: k150px,
                          padding: const EdgeInsets.all(k15px),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: const BorderRadius.all(Radius.circular(k10px))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: k150px,
                                height: k150px,
                                child: Stack(
                                  children: [
                                    Positioned.fill(child: Image.network(sampleVideoList[index].thumbnail ?? '', fit: BoxFit.fill, loadingBuilder: (context, child, loadingProgress){
                                      if(loadingProgress == null){
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: kWhite,
                                          ),
                                        );
                                      }
                                    },),),
                                    Positioned.fill(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [Colors.transparent, Colors.black],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              )
                                          ),
                                        )
                                    ),
                                    Positioned.fill(child: Icon(Icons.play_circle, color: kWhite, size: k30px,))
                                  ],
                                ),
                              ),
                              const HorizontalSpacingWidget(w: k40px),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EasyTextWidget(text: "Title: ${sampleVideoList[index].title ?? ''}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                  const VerticalSpacingWidget(h: k5px),
                                  EasyTextWidget(text: "Duration: ${context.read<TeacherSampleVideoPageBloc>().formatDuration(double.parse(sampleVideoList[index].videoDuration ?? ''))}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                      itemCount: sampleVideoList.length
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


class UploadSampleVideoButtonView extends StatelessWidget {
  final CourseVO course;
  final TeacherVO? teacher;
  const UploadSampleVideoButtonView({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kPrimaryColor), maximumSize: const MaterialStatePropertyAll(Size(k150px, k50px)), minimumSize: const MaterialStatePropertyAll(Size(k150px, k50px))),
          onPressed: (){
            context.navigateToNextScreenReplace(context, UploadSampleVideoPage(course: course, teacher: teacher,));
          },
          child: Text("Upload Video", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: 15, fontWeight: FontWeight.normal)),)
      ),
    );
  }
}

class TeacherPaidVideoPage extends StatelessWidget {
  final TeacherVO? teacher;
  final CourseVO course;
  const TeacherPaidVideoPage({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherPaidVideoPageBloc>(
      create: (_) => TeacherPaidVideoPageBloc(course.teacherID ?? '', course.categoryID ?? '', course.courseID ?? ''),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: k10px),
          child: Selector<TeacherPaidVideoPageBloc, List<VideoVO>?>(
            selector: (_, bloc) => bloc.getPaidVideoList,
            builder: (_, paidVideoList, child) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacingWidget(h: k15px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EasyTextWidget(text: 'Paid Videos', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.normal),
                    UploadPaidVideoButtonView(course: course, teacher:  teacher,)
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.55,
                  child: (paidVideoList == null) ? Center(child: EasyTextWidget(text: 'There is no video.', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),)
                      : ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: (){
                          context.navigateToNextScreenReplace(context, VideoPage(videoPath: paidVideoList[index].videoPath ?? ''));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: k150px,
                          padding: const EdgeInsets.all(k15px),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(k10px))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: k150px,
                                height: k150px,
                                child: Stack(
                                  children: [
                                    Positioned.fill(child: Image.network(paidVideoList[index].thumbnail ?? '', fit: BoxFit.fill, loadingBuilder: (context, child, loadingProgress){
                                      if(loadingProgress == null){
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: kWhite,
                                          ),
                                        );
                                      }
                                    },),),
                                    Positioned.fill(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Colors.transparent, Colors.black],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            )
                                          ),
                                        )
                                    ),
                                    Positioned.fill(child: Icon(Icons.play_circle, color: kWhite, size: k30px,))
                                  ],
                                ),
                              ),
                              const HorizontalSpacingWidget(w: k40px),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EasyTextWidget(text: "Title: ${paidVideoList[index].title ?? ''}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                  const VerticalSpacingWidget(h: k5px),
                                  EasyTextWidget(text: "Duration: ${context.read<TeacherPaidVideoPageBloc>().formatDuration(double.parse(paidVideoList[index].videoDuration ?? ''))}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                      itemCount: paidVideoList.length
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

class UploadPaidVideoButtonView extends StatelessWidget {
  final CourseVO course;
  final TeacherVO? teacher;
  const UploadPaidVideoButtonView({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kPrimaryColor), maximumSize: const MaterialStatePropertyAll(Size(150.0, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(150.0, 50.0))),
          onPressed: (){
            context.navigateToNextScreenReplace(context, UploadPaidVideoPage(course: course, teacher: teacher,));
          },
          child: Text("Upload Video", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: 15, fontWeight: FontWeight.normal)),)
      ),
    );
  }
}

class TeacherCourseFolderPage extends StatelessWidget {
  final CourseVO course;
  const TeacherCourseFolderPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherFolderPageBloc>(
        create: (_) => TeacherFolderPageBloc(course.teacherID ?? '', course.categoryID ?? '', course.courseID ?? ''),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(k20px),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<TeacherFolderPageBloc, List<FileVO>?>(
                  selector: (_, bloc) => bloc.getLectureFileList,
                  builder: (_, lectureFileList, child) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: kPrimaryColor, width: 0.5))
                          ),
                          height: k50px,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const LectureFolderView(),
                              UploadLectureFileButtonView(course: course)
                            ],
                          ),
                        ),
                        Selector<TeacherFolderPageBloc, bool>(
                          selector: (_, bloc) => bloc.isLectureClicked,
                          builder: (_, isClicked, child) => (isClicked) ? Container(
                            color: kPrimaryColor,
                            width: MediaQuery.of(context).size.width,
                            height: k300px,
                            child: Selector<TeacherFolderPageBloc, List<FileVO>?>(
                              selector: (_, bloc) => bloc.getLectureFileList,
                              builder: (_, lectureFileList, child) => (lectureFileList == null) ?
                              Center(
                                child: EasyTextWidget(text: "There is no lecture file", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                              ) :ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => GestureDetector(
                                    onTap: (){launchUrl(Uri.parse(lectureFileList?[index].filePath ?? ''));},
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
                                    )),
                                separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k15px),
                                itemCount: lectureFileList?.length ?? 0,
                              )
                            ),
                          ) : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                Selector<TeacherFolderPageBloc, bool>(
                  selector: (_, bloc) => bloc.isAssignmentClicked,
                  builder: (_, isClicked, child) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: k50px,
                    decoration: BoxDecoration(
                        border: (isClicked) ? Border.all(color: Colors.transparent, width: 0) : Border(bottom: BorderSide(color: kPrimaryColor, width: 0.5))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AssignmentFolderView(),
                        UploadAssignmentFileButtonView(course: course,)
                      ],
                    ),
                  ),
                ),
                Selector<TeacherFolderPageBloc, bool>(
                    selector: (_, bloc) => bloc.isAssignmentClicked,
                    builder: (_, isClicked, child) => (isClicked)? Container(
                      color: kPrimaryColor,
                      width: MediaQuery.of(context).size.width,
                      height: k300px,
                      padding: const EdgeInsets.symmetric(horizontal: k20px),
                      child: Selector<TeacherFolderPageBloc, List<FileVO>?>(
                        selector: (_, bloc) => bloc.getAssignmentFileList,
                        builder: (_, assignmentList, child) => (assignmentList == null) ?
                        Center(
                          child: EasyTextWidget(text: 'There is no assignment files', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                        ) : ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              launchUrl(Uri.parse(assignmentList?[index].filePath ?? ''));
                            },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                height: k30px,
                                padding: const EdgeInsets.symmetric(horizontal: k20px),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: kWhite, width: 0.5))
                                ),
                                child: EasyTextWidget(text: assignmentList?[index].fileName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k5px),
                          itemCount: assignmentList?.length ?? 0,
                        )
                      ),
                    ) : const SizedBox()
                ),
                Selector<TeacherFolderPageBloc, bool>(
                  selector: (_, bloc) => bloc.isStudentAssignmentClicked,
                  builder: (_, isClicked, child) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: k50px,
                    decoration: BoxDecoration(
                        border: (isClicked) ? Border.all(color: Colors.transparent, width: 0) : Border(bottom: BorderSide(color: kPrimaryColor, width: 0.5))
                    ),
                    child: const StudentAssignmentFolderView(),
                  ),
                ),
                Selector<TeacherFolderPageBloc, bool>(
                    selector: (_, bloc) => bloc.isStudentAssignmentClicked,
                    builder: (_, isClicked, child) => (isClicked)? Container(
                      color: kPrimaryColor,
                      width: MediaQuery.of(context).size.width,
                      height: k400px,
                      padding: const EdgeInsets.symmetric(horizontal: k10px),
                      child: Selector<TeacherFolderPageBloc, List<AssignmentVO>?>(
                        selector: (_, bloc) => bloc.getStudentFileList,
                        builder: (_, studentFileList, child) => Selector<TeacherFolderPageBloc, TextEditingController>(
                          selector: (_, bloc) => bloc.getMarkController,
                          builder: (_, markController, child) => Selector<TeacherFolderPageBloc, TextEditingController>(
                            selector: (_, bloc) => bloc.getCommentController,
                            builder: (_, commentController, child) => (studentFileList==null) ?
                            Center(
                              child: EasyTextWidget(text: 'There is no student assignment file', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                            ) : ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    showMarkCommentDialog(
                                        context: context,
                                        markController: markController,
                                        commentController: commentController,
                                        onPressed: (){
                                          loadingDialog(context: context);
                                          context.read<TeacherFolderPageBloc>().commentAssignment(studentFileList[index]);
                                          Navigator.pop(context);
                                        },
                                        d: true,
                                        studentAssignment: studentFileList![index]);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: (studentFileList[index].studentMark == null) ? 50 : 100,
                                    padding: const EdgeInsets.symmetric(horizontal: k20px, vertical: k10px),
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: const BorderRadius.all(Radius.circular(k20px))
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              EasyTextWidget(text: 'File Name:', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                              GestureDetector(
                                                onTap: (){

                                                },
                                                child: EasyTextWidget(text: studentFileList?[index].fileName ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal,),),
                                              const HorizontalSpacingWidget(w: k20px),
                                              EasyTextWidget(text: 'Upload By: ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                              EasyTextWidget(text: studentFileList?[index].uploadedByName ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal,),
                                            ],
                                          ),
                                        ),
                                        const VerticalSpacingWidget(h: k5px),
                                        (studentFileList[index].studentMark == null) ? const SizedBox() : EasyTextWidget(text: "Marks: ${studentFileList[index].studentMark}", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                        const VerticalSpacingWidget(h: k5px),
                                        (studentFileList[index].studentMark == null) ? const SizedBox() : EasyTextWidget(text: "Comment: ${studentFileList[index].teacherComment}", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                              itemCount: studentFileList?.length ?? 0,
                            )
                          ),
                        ),
                      ),
                    ) : const SizedBox()
                )
              ],
            ),
          ),
        ),
    )
    ;
  }
}



class TeacherChatPage extends StatelessWidget {
  final TeacherVO? teacher;
  final CourseVO course;
  const TeacherChatPage({super.key, required this.course, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherChatPageBloc>(
      create: (_) => TeacherChatPageBloc(course.courseID ?? ''),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: EasyTextWidget(text: 'Enrolled Student Lists', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.55,
                child: Selector<TeacherChatPageBloc, List<EnrollmentVO>?>(
                  selector: (_, bloc) => bloc.getEnrollList,
                  builder: (_, enrollmentList, child) => ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        context.read<TeacherChatPageBloc>().createChatRoom(context, teacher?.teacherID ?? '', enrollmentList?[index].studentID ?? '', enrollmentList?[index].studentName ?? '');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: k100px,
                        padding: const EdgeInsets.symmetric(horizontal: k20px),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(k15px))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: Image.network(enrollmentList?[index].profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
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
                            const HorizontalSpacingWidget(w: k20px),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: k100px,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      EasyTextWidget(text: 'Student Name: ', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                      const HorizontalSpacingWidget(w: k10px),
                                      EasyTextWidget(text: enrollmentList?[index].studentName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                                    ],
                                  ),
                                  const VerticalSpacingWidget(h: k10px),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      EasyTextWidget(text: 'Enrolled Date: ', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                      const HorizontalSpacingWidget(w: k10px),
                                      EasyTextWidget(text: enrollmentList?[index].enrollDate ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                                    ],
                                  ),
                                ],
                              )
                            ),

                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                    itemCount: enrollmentList?.length ?? 0,
                  ),
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
        context.read<TeacherFolderPageBloc>().setLectureClicked();
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
        context.read<TeacherFolderPageBloc>().setAssignmentClicked();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.folder, size: k25px, color: kPrimaryColor,),
          const HorizontalSpacingWidget(w: k5px),
          EasyTextWidget(text: 'assignment_folder/', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
        ],
      )
    );
  }
}

class StudentAssignmentFolderView extends StatelessWidget {
  const StudentAssignmentFolderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<TeacherFolderPageBloc>().setStudentAssignmentClicked();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.folder, size: k25px, color: kPrimaryColor,),
          const HorizontalSpacingWidget(w: k5px),
          EasyTextWidget(text: 'student_assignment_folder/', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}

class UploadLectureFileButtonView extends StatelessWidget {
  final CourseVO course;
  const UploadLectureFileButtonView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<TeacherFolderPageBloc>().pickAndUploadLectureFile(course, context);
        },
        icon: Icon(Icons.add, color: kPrimaryColor, size: k25px,)
    );
  }
}

class UploadAssignmentFileButtonView extends StatelessWidget {
  final CourseVO course;
  const UploadAssignmentFileButtonView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<TeacherFolderPageBloc>().pickAndUploadAssignmentFile(course, context);
        },
        icon: Icon(Icons.add, color: kPrimaryColor, size: k25px,)
    );
  }
}

class SubmitCommentButton extends StatelessWidget {
  final AssignmentVO assignment;
  const SubmitCommentButton({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kPrimaryColor), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
        onPressed: (){
          context.read<TeacherFolderPageBloc>().commentAssignment(assignment);
        },
        child: Text("SUBMIT", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
    );
  }
}








