import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/teacher_home_page_bloc.dart';
import 'package:myanmar_educational/data/vos/category_vo/category_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/selecting_category_page.dart';
import 'package:myanmar_educational/pages/teacher_account_detail_page.dart';
import 'package:myanmar_educational/pages/teacher_course_detail_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_widget.dart';
import '../widgets/horizontal_spacing_widget.dart';

class TeacherHomePage extends StatelessWidget {
  final TeacherVO? teacher;
  const TeacherHomePage({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherHomePageBloc>(
      create: (_) => TeacherHomePageBloc(teacher?.teacherID ?? ''),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: Image.asset(kMyanmarEducationalLogo, width: k25px, height: k25px,),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
          actions: const [
              LogoutButton()
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: k20px, horizontal: k10px),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    context.navigateToNextScreenReplace(context, TeacherAccountDetailPage(admin: null, teacher: teacher,));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: k100px,
                    padding: const EdgeInsets.symmetric(horizontal: k20px),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(10, 10),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                              size: const Size.fromRadius(k25px),
                              child: teacher?.profile == null ? Center(child: CircularProgressIndicator(color: kSecondaryColor,),) : Image.network(teacher?.profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
                                if(loadingProgress == null){
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(color: kSecondaryColor,),
                                  );
                                }
                              },)
                          ),
                        ),
                        const HorizontalSpacingWidget(w: k15px),
                        EasyTextWidget(text: "${teacher?.firstName ?? ''}'s Dashboard", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                      ],
                    ),
                  ),
                ),
                const VerticalSpacingWidget(h: k20px),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: k250px,
                  padding: const EdgeInsets.all(k20px),
                  decoration: BoxDecoration(
                    color: kTertiaryColor,
                    borderRadius: BorderRadius.circular(k20px),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(10, 10),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EasyTextWidget(text: 'Courses And Enrolled Students Information', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                      const VerticalSpacingWidget(h: k20px),
                      Selector<TeacherHomePageBloc, int>(
                        selector: (_, bloc) => bloc.getNumberOfCourse,
                        builder: (_, numberOfCourse, child) => Selector<TeacherHomePageBloc, int>(
                          selector: (_, bloc) => bloc.getNumberOfStudent,
                          builder: (_, numberOfStudent, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *0.4,
                                height: k150px,
                                child: Stack(
                                  children: [
                                    PieChart(
                                        swapAnimationDuration: const Duration(milliseconds: 1000),
                                        swapAnimationCurve: Curves.linearToEaseOut,
                                        PieChartData(
                                            startDegreeOffset: 180.0,
                                            sections: [
                                              PieChartSectionData(
                                                  value: (numberOfCourse).toDouble(),
                                                  color: kPrimaryColor,
                                                  title: '${numberOfCourse.toDouble()}',
                                                  titleStyle: TextStyle(color: kWhite),
                                                  radius: k30px
                                              ),
                                              PieChartSectionData(
                                                  value: (numberOfStudent).toDouble(),
                                                  color: kSecondaryColor,
                                                  radius: k30px
                                              ),
                                            ]
                                        )
                                    ),
                                    Center(child: SizedBox(
                                      width: 60,
                                      height: 50,
                                      child: EasyTextWidget(text: 'No. of courses & enroll students', textColor: kPrimaryColor, textSize: 11, fontWeight: FontWeight.normal),
                                    ))
                                  ],
                                ),
                              ),
                              const HorizontalSpacingWidget(w: k15px),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.4,
                                height: k150px,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: k25px,
                                          height: k25px,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                        const HorizontalSpacingWidget(w: k10px),
                                        EasyTextWidget(text: 'No. of course', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                      ],
                                    ),
                                    const VerticalSpacingWidget(h: k10px),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: k25px,
                                          height: k25px,
                                          decoration: BoxDecoration(
                                              color: kSecondaryColor,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                        const HorizontalSpacingWidget(w: k10px),
                                        SizedBox(
                                          width: 125,
                                          height: k50px,
                                          child: EasyTextWidget(text: 'No. of Enrolled Student', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const VerticalSpacingWidget(h: k10px),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EasyTextWidget(text: 'Your Courses', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
                      ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kPrimaryColor), maximumSize: const MaterialStatePropertyAll(Size(k200px, k40px)), minimumSize: const MaterialStatePropertyAll(Size(k150px, k40px))),
                          onPressed: (){
                            context.navigateToNextScreenReplace(context, SelectingCategoryPage(teacherID: teacher?.teacherID ?? '', teacherName: "${teacher?.firstName} ${teacher?.lastName}", teacher: teacher,));
                          },
                          child: Text("CREATE COURSE", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal)),)
                      )
                    ],
                  ),
                ),
                const VerticalSpacingWidget(h: k20px),
                Selector<TeacherHomePageBloc, List<CategoryVO>?>(
                  selector: (_, bloc) => bloc.getCategoryList,
                  builder: (_, categoryList, child) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: (){
                                context.read<TeacherHomePageBloc>().changeCourse(teacher?.teacherID ?? '', categoryList?[index].categoryID ?? '');
                              },
                              child: Container(
                                width: k150px,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: kTertiaryColor,
                                    border: Border.all(
                                      color: kPrimaryColor
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(5, 5),
                                        blurRadius: 5,
                                        spreadRadius: 0.5,
                                      )
                                    ]
                                ),
                                child: Center(child: EasyTextWidget(text: categoryList?[index].categoryName ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)),
                              ),
                            ),
                            separatorBuilder: (context, index) => const HorizontalSpacingWidget(w: k10px),
                            itemCount: categoryList?.length ?? 0
                        ),
                      ),
                      const VerticalSpacingWidget(h: k20px),
                      CourseView(teacher: teacher,),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseView extends StatelessWidget {
  final TeacherVO? teacher;
  const CourseView({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Selector<TeacherHomePageBloc, List<CourseVO>?>(
      selector: (_, bloc) => bloc.getCourseList,
      builder: (_, courseList, child) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: k350px,
            child: (courseList?.isEmpty ?? false) ? Center(child: EasyTextWidget(text: 'There is no course in this category', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),) :
            ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    context.navigateToNextScreenReplace(context, TeacherCourseDetailPage(teacher: teacher, course: courseList![index]));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 330,
                        height: k200px,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent, width: 0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                        ),
                        child: Container(
                          width: 330,
                          height: k100px,
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
                            borderRadius: BorderRadius.circular(k20px),
                            child: (courseList?[index].photo == null)? Image.asset(kDefaultCourseImage, fit: BoxFit.cover,) : Image.network(courseList?[index].photo ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
                              if (loadingProgress == null){
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                );
                              }
                            },),
                          )
                        )
                      ),
                      const VerticalSpacingWidget(h: k10px),
                      SizedBox(
                        width: 330,
                        height: k100px,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 330,
                              height: k30px,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: k50px,
                                    height: k30px,
                                    child: EasyTextWidget(text: 'Title :', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    width: 280,
                                    height: k30px,
                                    child: EasyTextWidget(text: courseList?[index].title ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 330,
                              height: k30px,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 165,
                                    height: k30px,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: k50px,
                                          height: k30px,
                                          child: EasyTextWidget(text: 'Price : ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          width: 115,
                                          height: k30px,
                                          child: EasyTextWidget(text: "${courseList?[index].price ?? ''}MMK", textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 165,
                                    height: k30px,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 75,
                                          height: k30px,
                                          child: EasyTextWidget(text: 'Duration : ', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          width: 90,
                                          height: k30px,
                                          child: EasyTextWidget(text: courseList?[index].duration ?? '', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => const HorizontalSpacingWidget(w: k25px),
                itemCount: courseList?.length ?? 0
            )
        );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<TeacherHomePageBloc>().logout(context);
        },
        icon: Icon(Icons.logout, size: k25px, color: kWhite,)
    );
  }
}


