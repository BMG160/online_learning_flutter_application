import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myanmar_educational/bloc/staff_dashboard_bloc.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/data/vos/enrollment_vo/enrollment_vo.dart';
import 'package:myanmar_educational/data/vos/request_vo/request_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/staff_registration_page.dart';
import 'package:myanmar_educational/pages/manage_enroll_request_page.dart';
import 'package:myanmar_educational/pages/managing_student_page.dart';
import 'package:myanmar_educational/pages/managing_teacher_page.dart';
import 'package:myanmar_educational/pages/teacher_registration_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_widget.dart';

class StaffDashboard extends StatelessWidget {
  final AdminVO admin;
  const StaffDashboard({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StaffDashboardBloc>(
      create: (_) => StaffDashboardBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
          leading: Image.asset(kMyanmarEducationalLogo, width: k25px, height: k25px,),
          actions: const [
            LogoutView(),
            HorizontalSpacingWidget(w: k15px)
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Selector<StaffDashboardBloc, AdminVO?>(
            selector: (_, bloc) => bloc.getAdmin,
            builder: (_, adminInfo, child) => Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: k20px, horizontal: k10px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shadowColor: Colors.grey,
                    elevation: k20px,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(k20px)
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(k20px),
                      tileColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(k20px)
                      ),
                      leading: ClipOval(
                        child: SizedBox.fromSize(
                            size: const Size.fromRadius(k30px),
                            child: adminInfo?.profile == null ? const Center(child: CircularProgressIndicator(),) : Image.network(adminInfo?.profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
                              if(loadingProgress == null){
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(color: kWhite,),
                                );
                              }
                            },)
                        ),
                      ),
                      title: EasyTextWidget(text: "${adminInfo?.firstName ?? ''}'s Dashboard", textColor: kWhite, textSize: k20px, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const VerticalSpacingWidget(h: k30px),
                  ////Teacher And Student View
                  Selector<StaffDashboardBloc, List<TeacherVO>?>(
                    selector: (_, bloc) => bloc.getTeacherList,
                    builder: (_, teacherList, child) => Selector<StaffDashboardBloc, List<StudentVO>?>(
                      selector: (_, bloc) => bloc.getStudentList,
                      builder: (_, studentList, child) => Selector<StaffDashboardBloc, List<AdminVO>?>(
                        selector: (_, bloc) => bloc.getAdminList,
                        builder: (_, adminList, child) => Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: k20px, horizontal: k10px),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(k20px)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.5, 0.5),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: k35px,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: k300px,
                                      child: EasyTextWidget(text: "Staff, Teacher & Student Information", textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w600),
                                    ),
                                    Selector<StaffDashboardBloc, PopUpMenuItemList?>(
                                      selector: (_, bloc) => bloc.getSelectedMenu,
                                      builder: (_, selectedMenu, child) => PopupMenuButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: kWhite,
                                            size: k25px,
                                          ),
                                          onSelected: (PopUpMenuItemList selectedMenu){
                                            if(selectedMenu == PopUpMenuItemList.Teacher){
                                              context.navigateToNextScreenReplace(context, ManagingTeacherPage(admin: admin));
                                            }
                                            if(selectedMenu == PopUpMenuItemList.Student){
                                              context.navigateToNextScreenReplace(context, ManagingStudentPage(admin: admin,));
                                            }
                                            if(selectedMenu == PopUpMenuItemList.Register_Teacher){
                                              context.navigateToNextScreenReplace(context, TeacherRegistrationPage(admin: admin));
                                            }
                                            if(selectedMenu == PopUpMenuItemList.Register_Admin){
                                              context.navigateToNextScreenReplace(context, const AdminRegistrationPage());
                                            }
                                          },
                                          itemBuilder: (context) => <PopupMenuEntry<PopUpMenuItemList>>[
                                            PopupMenuItem<PopUpMenuItemList>(
                                                value: PopUpMenuItemList.Teacher,
                                                child: EasyTextWidget(text: 'View Teacher', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                            ),
                                            PopupMenuItem<PopUpMenuItemList>(
                                                value: PopUpMenuItemList.Student,
                                                child: EasyTextWidget(text: 'View Student', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                            ),
                                            PopupMenuItem<PopUpMenuItemList>(
                                                value: PopUpMenuItemList.Register_Teacher,
                                                child: EasyTextWidget(text: 'Register Teacher', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                            ),
                                            (admin.role == 'Manager') ? PopupMenuItem<PopUpMenuItemList>(
                                                value: PopUpMenuItemList.Register_Admin,
                                                child: EasyTextWidget(text: 'Register Staff', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                            ) : const PopupMenuItem<PopUpMenuItemList>(
                                                enabled: false,
                                                value: PopUpMenuItemList.Register_Admin,
                                                child: EasyTextWidget(text: 'Register Staff', textColor: Colors.grey, textSize: k15px, fontWeight: FontWeight.normal)
                                            ),
                                          ]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const VerticalSpacingWidget(h: k25px),
                              Row(
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
                                                      value: (teacherList?.length ?? 0).toDouble(),
                                                      color: Colors.white,
                                                      radius: k30px
                                                  ),
                                                  PieChartSectionData(
                                                      value: (studentList?.length ?? 0).toDouble(),
                                                      color: kSecondaryColor,
                                                      radius: k30px
                                                  ),
                                                  (admin.role == 'Manager') ?
                                                      PieChartSectionData(
                                                        value: (adminList?.length ?? 0).toDouble(),
                                                        color: Colors.grey,
                                                        radius: k30px
                                                      ) : PieChartSectionData(
                                                    value:  0.0
                                                  )
                                                ]
                                            )
                                        ),
                                        Center(child: SizedBox(
                                          width: 60,
                                          height: 50,
                                          child: EasyTextWidget(text: 'No. of teacher & student', textColor: kWhite, textSize: 11, fontWeight: FontWeight.normal),
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
                                                  color: kWhite,
                                                  shape: BoxShape.circle
                                              ),
                                            ),
                                            const HorizontalSpacingWidget(w: k10px),
                                            EasyTextWidget(text: 'No. of Teacher', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
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
                                            EasyTextWidget(text: 'No. of Student', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                                          ],
                                        ),
                                        const VerticalSpacingWidget(h: k10px),
                                        (admin.role == 'Manager') ?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: k25px,
                                              height: k25px,
                                              decoration: const BoxDecoration(
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle
                                              ),
                                            ),
                                            const HorizontalSpacingWidget(w: k10px),
                                            EasyTextWidget(text: 'No. of Admin', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
                                          ],
                                        ) : const SizedBox()
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpacingWidget(h: k50px),
                  ////Course View
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: k20px, horizontal: k10px),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        ],
                        color: kTertiaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(k20px))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: k50px,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              EasyTextWidget(text: 'Course Information', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
                              Selector<StaffDashboardBloc, PopUpMenuItemList?>(
                                selector: (_, bloc) => bloc.getSelectedMenu,
                                builder: (_, selectedMenu, child) => PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: kPrimaryColor,
                                      size: k25px,
                                    ),
                                    onSelected: (PopUpMenuItemList selectedMenu){
                                      if(selectedMenu == PopUpMenuItemList.Pending){
                                        context.navigateToNextScreenReplace(context, const ManageEnrollRequestPage());
                                      }
                                    },
                                    itemBuilder: (context) => <PopupMenuEntry<PopUpMenuItemList>>[
                                      PopupMenuItem<PopUpMenuItemList>(
                                          value: PopUpMenuItemList.Pending,
                                          child: EasyTextWidget(text: 'View Pending Request', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                      ),
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                        const VerticalSpacingWidget(h: k20px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Selector<StaffDashboardBloc, List<CourseVO>?>(
                              selector: (_, bloc) => bloc.getCourseList,
                              builder: (_, courseList, child) => Selector<StaffDashboardBloc, List<EnrollmentVO>?>(
                                selector: (_, bloc) => bloc.getEnrollmentList,
                                builder: (_, enrollmentList, child) => Selector<StaffDashboardBloc, List<RequestVO>?>(
                                  selector: (_, bloc) => bloc.getRequestList,
                                  builder: (_, requestList, child) => SizedBox(
                                    width: MediaQuery.of(context).size.width*0.4,
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
                                                      value: (courseList?.length ?? 0).toDouble(),
                                                      title: '${(courseList?.length ?? 0).toDouble()}',
                                                      titleStyle: TextStyle(color: kWhite),
                                                      color: kPrimaryColor,
                                                      radius: k30px
                                                  ),
                                                  PieChartSectionData(
                                                      value: (enrollmentList?.length ?? 0).toDouble(),
                                                      title: '${(enrollmentList?.length ?? 0).toDouble()}',
                                                      titleStyle: TextStyle(color: kWhite),
                                                      color: kSecondaryColor,
                                                      radius: k30px
                                                  ),
                                                  PieChartSectionData(
                                                      value: (requestList?.length ?? 0).toDouble(),
                                                      title: '${(requestList?.length ?? 0).toDouble()}',
                                                      titleStyle: TextStyle(color: kWhite),
                                                      color: Colors.green,
                                                      radius: k30px
                                                  ),
                                                ]
                                            )
                                        ),
                                        Center(
                                            child: SizedBox(
                                              width: 70,
                                              height: 50,
                                              child: Center(child: EasyTextWidget(text: "Courses' Information", textColor: kPrimaryColor, textSize: 12, fontWeight: FontWeight.normal)),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
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
                                      EasyTextWidget(text: 'No. of enrollment', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
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
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                      const HorizontalSpacingWidget(w: k10px),
                                      EasyTextWidget(text: 'No. of pending', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal)
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<StaffDashboardBloc>().logout(context);
        },
        icon: Icon(Icons.logout, color: kWhite, size: k30px,)
    );
  }
}

