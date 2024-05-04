import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/managing_teacher_page_bloc.dart';
import 'package:myanmar_educational/data/vos/admin_vo/admin_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/teacher_account_detail_page.dart';
import 'package:myanmar_educational/pages/teacher_registration_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_widget.dart';

class ManagingTeacherPage extends StatelessWidget {
  final AdminVO admin;
  const ManagingTeacherPage({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagingTeacherPageBloc>(
      create: (_) => ManagingTeacherPageBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_new, color: kWhite, size: k25px,)),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(k20px),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: EasyTextWidget(text: "All Teachers' Account", textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),),
                const VerticalSpacingWidget(h: k20px),
                Selector<ManagingTeacherPageBloc, List<TeacherVO>?>(
                  selector: (_,bloc) => bloc.getTeacherList,
                  builder: (_, teacherList, child) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.75,
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
                              context.navigateToNextScreenReplace(context, TeacherAccountDetailPage(admin: admin, teacher: teacherList?[index],));
                            },

                            tileColor: kPrimaryColor,
                            contentPadding: const EdgeInsets.all(k20px),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(k20px)
                            ),
                            leading: ClipOval(
                              child: SizedBox.fromSize(
                                  size: const Size.fromRadius(k30px),
                                  child: teacherList?[index].profile == null ? const Center(child: CircularProgressIndicator(),) : Image.network(teacherList?[index].profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
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
                            title: EasyTextWidget(text: "Name - ${teacherList?[index].firstName} ${teacherList?[index].lastName}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                            subtitle: EasyTextWidget(text: "Registration Date - ${teacherList?[index].accountRegistrationDate}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                          ),
                        ),
                        separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                        itemCount: teacherList?.length ?? 0
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: (){
            context.navigateToNextScreenReplace(context, TeacherRegistrationPage(admin: admin, teacher: null,));
          },
          child: Icon(Icons.add, color: kWhite, size: k25px,),
        ),
      ),
    );
  }
}
