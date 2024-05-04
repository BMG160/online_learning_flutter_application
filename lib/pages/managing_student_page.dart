import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/managing_student_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/student_vo/student_vo.dart';
import 'package:myanmar_educational/pages/student_account_detail_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

class ManagingStudentPage extends StatelessWidget {
  final AdminVO? admin;
  final StudentVO? student;
  const ManagingStudentPage({super.key, this.admin, this.student});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagingStudentPageBloc>(
      create: (_) => ManagingStudentPageBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: k25px,),
          ),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: EasyTextWidget(text: "All Student's Account", textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
              ),
              const VerticalSpacingWidget(h: k20px),
              Selector<ManagingStudentPageBloc, List<StudentVO>?>(
                selector: (_, bloc) => bloc.getStudentList,
                builder: (_, studentList, child) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.78,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => Card(
                        shadowColor: Colors.grey,
                        elevation: k20px,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(k20px)
                        ),
                        child: ListTile(
                          onTap: (){

                            context.navigateToNextScreenReplace(context, StudentAccountDetailPage(student: studentList?[index], admin: admin,));
                          },
                          tileColor: kPrimaryColor,
                          contentPadding: const EdgeInsets.all(k20px),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(k20px)
                          ),
                          leading: ClipOval(
                            child: SizedBox.fromSize(
                                size: const Size.fromRadius(k30px),
                                child: studentList?[index].profile == null ? const Center(child: CircularProgressIndicator(),) : Image.network(studentList?[index].profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
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
                          title: EasyTextWidget(text: "Name - ${studentList?[index].firstName} ${studentList?[index].lastName}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                          subtitle: EasyTextWidget(text: "Registration Date - ${studentList?[index].accountRegistrationDate}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                        ),
                      ),
                      separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                      itemCount: studentList?.length ?? 0
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
