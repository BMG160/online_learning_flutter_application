import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/free_student_course_detail_page_bloc.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/course_detail_page.dart';
import 'package:myanmar_educational/pages/sample_course_page.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';

class FreeStudentCourseDetailPage extends StatelessWidget {
  final StudentVO student;
  final CourseVO course;
  const FreeStudentCourseDetailPage({super.key, required this.course, required this.student});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CourseDetailPage(course: course, student: student,),
      SampleCoursePage(course: course)
    ];
    return ChangeNotifierProvider<FreeStudentCourseDetailPageBloc>(
      create: (_) => FreeStudentCourseDetailPageBloc(),
      child: Scaffold(
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
          body: Selector<FreeStudentCourseDetailPageBloc, int>(
            selector: (_, bloc) => bloc.getSelectedIndex,
            builder: (_, index, child) => pages[index],
          ),
        ),
        bottomNavigationBar: const BottomNavigationView(),
      ),
    );
  }
}

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<FreeStudentCourseDetailPageBloc, int>(
      selector: (_, bloc) => bloc.getSelectedIndex,
      builder: (_, selectedIndex, child) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kPrimaryColor,
          currentIndex: selectedIndex,
          selectedItemColor: kWhite,
          unselectedItemColor: kSecondaryColor,
          onTap: (index){
            context.read<FreeStudentCourseDetailPageBloc>().changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.details),
                label: 'Detail'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.details),
                label: 'Sample Video'
            ),
          ]
      ),
    );
  }
}
