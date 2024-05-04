import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/student_home_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/data/vos/category_vo/category_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/student_account_detail_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_widget.dart';

class StudentHomePage extends StatelessWidget {
  final StudentVO? student;
  const StudentHomePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BrowseCoursePage(student: student!,),
      MyCoursePage(student: student!,)
    ];
    return ChangeNotifierProvider<StudentHomePageBloc>(
      create: (_) => StudentHomePageBloc(student?.studentID ?? ''),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: Image.asset(kMyanmarEducationalLogo, width: k20px, height: k25px,),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
          actions: const [
            LogoutButton(),
            HorizontalSpacingWidget(w: k10px)
          ],
        ),
        body: Selector<StudentHomePageBloc, int>(
          selector: (_, bloc) => bloc.getSelectedIndex,
          builder: (_, index, child) => pages[index],
        ),
        bottomNavigationBar: const StudentHomeBottomNavigationView(),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<StudentHomePageBloc>().logout(context);
        },
        icon: Icon(Icons.logout, color: kWhite, size: k25px,)
    );
  }
}


class StudentHomeBottomNavigationView extends StatelessWidget {
  const StudentHomeBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<StudentHomePageBloc, int>(
      selector: (_, bloc) => bloc.getSelectedIndex,
      builder: (_, selectedIndex, child) => BottomNavigationBar(
          backgroundColor: kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: kWhite,
          unselectedItemColor: kSecondaryColor,
          onTap: (index){
            context.read<StudentHomePageBloc>().changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.browse_gallery),
                label: 'Browse'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books),
              label: 'MyCourse'
            )
          ],
      ),
    );
  }
}


class BrowseCoursePage extends StatelessWidget {
  final StudentVO student;
  const BrowseCoursePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(k20px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ////Student account information view----------------------------
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.45,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EasyTextWidget(text: 'Welcome,', textColor: kPrimaryColor, textSize: k25px, fontWeight: FontWeight.normal),
                        EasyTextWidget(text: '${student.firstName} ${student.lastName}', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      context.navigateToNextScreenReplace(context, StudentAccountDetailPage(student: student, admin: null,));
                    },
                    child: SizedBox(
                      width: k100px,
                      height: k100px,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                                size: const Size.fromRadius(k35px),
                                child: Image.network(student.profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
                                  if(loadingProgress == null){
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    );
                                  }
                                },)
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            //////-----------------------------------
            const VerticalSpacingWidget(h: k30px),
            ////Filter View
            Selector<StudentHomePageBloc, bool>(
              selector: (_, bloc) => bloc.isFilter,
              builder: (_, isFilter, child) => (isFilter) ? GestureDetector(
                onTap: (){
                  context.read<StudentHomePageBloc>().unFilter();
                },
                child: Container(
                  width: k100px,
                  height: k50px,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(k20px))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_alt_off, color: kWhite, size: k20px,),
                      EasyTextWidget(text: 'Un-filter', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                    ],
                  ),
                ),
              ) : Container(
                width: k100px,
                height: k50px,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(k20px))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.filter_alt, color: kWhite, size: k20px,),
                    EasyTextWidget(text: 'Filer', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                  ],
                ),
              ),
            ),
            const VerticalSpacingWidget(h: k20px),
            Selector<StudentHomePageBloc, List<CategoryVO>?>(
              selector: (_, bloc) => bloc.getCategoryList,
              builder: (_, categoryList, child) => SizedBox(
                width: MediaQuery.of(context).size.width,
                height: k50px,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        context.read<StudentHomePageBloc>().filterCourse(categoryList?[index].categoryID ?? '');
                      },
                      child: Container(
                        width: k150px,
                        height: k50px,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(5, 5),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                              )
                            ]
                        ),
                        child: Center(child: EasyTextWidget(text: categoryList?[index].categoryName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),),
                      ),
                    ),
                    separatorBuilder: (context, index) => const HorizontalSpacingWidget(w: k10px),
                    itemCount: categoryList?.length ?? 0),
              ),
            ),
            ////--------------------------------------------
            const VerticalSpacingWidget(h: k20px),
            ////Course View
            EasyTextWidget(text: 'All Courses', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.normal),
            const VerticalSpacingWidget(h: k30px),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: k250px,
              child: Selector<StudentHomePageBloc, List<CourseVO>?>(
                selector: (_, bloc) => bloc.getCourseList,
                builder: (_, courseList, child) => (courseList == null) ? Center(child: EasyTextWidget(text: 'There is no course', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),) :
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        context.read<StudentHomePageBloc>().checkEnrollment(context, student, courseList[index]);
                      },
                      child: SizedBox(
                        width: k300px,
                        height: k300px,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ////Course Image View-------------------------
                            Container(
                              width: k300px,
                              height: k150px,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(10, 10),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  )
                                ]
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                                child: Image.network(courseList[index].photo ?? '', fit: BoxFit.fill, loadingBuilder: (context, child, loadingProgress){
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
                            const VerticalSpacingWidget(h: k15px),
                            SizedBox(
                              width: k300px,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EasyTextWidget(text: 'Title - ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                  EasyTextWidget(text: courseList[index].title ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                ],
                              ),
                            ),
                            const VerticalSpacingWidget(h: k5px),
                            SizedBox(
                              width: k300px,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: k300px,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.timelapse, color: kPrimaryColor, size: k20px,),
                                            const HorizontalSpacingWidget(w: k5px),
                                            EasyTextWidget(text: courseList[index].duration ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.attach_money, color: kPrimaryColor, size: k20px,),
                                            const HorizontalSpacingWidget(w: k5px),
                                            EasyTextWidget(text: "${courseList[index].price ?? ''}MMK", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const VerticalSpacingWidget(h: k5px),
                            SizedBox(
                                width: k300px,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.date_range, color: kPrimaryColor, size: k20px,),
                                        const HorizontalSpacingWidget(w: k5px),
                                        EasyTextWidget(text: courseList[index].startDate ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.person, color: kPrimaryColor, size: k20px,),
                                        const HorizontalSpacingWidget(w: k5px),
                                        EasyTextWidget(text: courseList[index].teacherName ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                      ],
                                    ),
                                  ],
                                )
                            ),
                            const VerticalSpacingWidget(h: k5px),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const HorizontalSpacingWidget(w: k20px),
                  itemCount: courseList.length,
                )
              ),
            )
            ////---------------------------------------------
          ],
        ),
      ),
    );
  }
}



class MyCoursePage extends StatelessWidget {
  final StudentVO student;
  const MyCoursePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Selector<StudentHomePageBloc, List<EnrollmentVO>?>(
        selector: (_, bloc) => bloc.getMyCourseList,
        builder: (_, myCourseList, child) => (myCourseList == null) ? Center(
          child: EasyTextWidget(text: 'There is no enroll course', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
        ) : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EasyTextWidget(text: 'Your Courses', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.normal),
              const VerticalSpacingWidget(h: k10px),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.69,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        context.read<StudentHomePageBloc>().checkStudentEnrollment(context, student, myCourseList[index].courseID ?? '');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: k100px,
                        padding: const EdgeInsets.all(k10px),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(5, 5),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(myCourseList[index].courseImage, width: 100, height: 100, loadingBuilder: (context, child, loadingProgress){
                              if(loadingProgress == null){
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: kWhite,
                                  ),
                                );
                              }
                            },),
                            const HorizontalSpacingWidget(w: k20px),
                            EasyTextWidget(text: myCourseList[index].courseName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                    itemCount: myCourseList.length
                ),
              )
            ],
          ),
        )
      )
    );
  }
}


