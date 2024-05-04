import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/enroll_student_course_detail_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/folder_page.dart';
import 'package:myanmar_educational/pages/paid_course_page.dart';
import 'package:myanmar_educational/pages/private_chat_page.dart';
import 'package:myanmar_educational/pages/sample_course_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:provider/provider.dart';

class EnrollStudentCourseDetailPage extends StatelessWidget {
  final StudentVO student;
  final CourseVO course;
  final String chatRoomID;
  final String senderID;
  const EnrollStudentCourseDetailPage({super.key, required this.course, required this.student, required this.chatRoomID, required this.senderID});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      SampleCoursePage(course: course),
      PaidCoursePage(course: course),
      FolderPage(course: course, student: student,),
    ];
    return ChangeNotifierProvider<EnrollStudentCourseDetailPageBloc>(
      create: (_) => EnrollStudentCourseDetailPageBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              SliverAppBar(
                expandedHeight: k200px,
                flexibleSpace: FlexibleSpaceBar(
                  background: (course.photo==null) ? Image.asset(kDefaultCourseImage) : Image.network(course.photo ?? '', fit: BoxFit.fill, loadingBuilder: (context, child, loadingProgress){
                    if(loadingProgress == null){
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white,),
                      );
                    }
                  },),

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
          body: Selector<EnrollStudentCourseDetailPageBloc, int>(
            selector: (_, bloc) => bloc.getSelectedIndex,
            builder: (_, index, child) => pages[index],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
            onPressed: (){
              context.navigateToNextScreenReplace(context, PrivateChatPage(chatRoomID: chatRoomID, senderID: senderID, name: course.teacherName ?? '',));
            },
            child: Icon(
              Icons.messenger,
              color: kWhite,
              size: k25px,
            ),
        ),
        bottomNavigationBar: const SampleCoursePageBottomNavigationView(),
      ),
    );
  }
}

class SampleCoursePageBottomNavigationView extends StatelessWidget {
  const SampleCoursePageBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<EnrollStudentCourseDetailPageBloc, int>(
      selector: (_, bloc) => bloc.getSelectedIndex,
      builder: (_, selectedIndex, child) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryColor,
        currentIndex: selectedIndex,
        selectedItemColor: kWhite,
        unselectedItemColor: kSecondaryColor,
        onTap: (index){
          context.read<EnrollStudentCourseDetailPageBloc>().changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.money_off),
              label: 'Sample'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Paid'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Folder'
          ),
        ],
      ),
    );
  }
}



