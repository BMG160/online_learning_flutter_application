import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/selecting_category_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/strings.dart';
import 'package:myanmar_educational/data/vos/category_vo/category_vo.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/pages/create_category_page.dart';
import 'package:myanmar_educational/pages/create_course_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/dimens.dart';

class SelectingCategoryPage extends StatelessWidget {
  final String teacherID;
  final String teacherName;
  final TeacherVO? teacher;
  const SelectingCategoryPage({super.key, required this.teacherID, required this.teacherName, this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectingCategoryPageBloc>(
      create: (_) => SelectingCategoryPageBloc(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: kWhite,
              size: k25px,
            ),
          ),
          centerTitle: true,
          title: EasyTextWidget(text: kAppName, textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w900),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: k20px),
            child: Selector<SelectingCategoryPageBloc, List<CategoryVO>?>(
              selector: (_, bloc) => bloc.getCategoryList,
              builder: (_, categoryList, child) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EasyTextWidget(text: 'Select Category For Your Course', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
                  const VerticalSpacingWidget(h: k30px),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.8,
                    padding: const EdgeInsets.symmetric(horizontal: k20px),
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: (){
                            context.navigateToNextScreenReplace(context, CreateCoursePage(categoryID: categoryList?[index].categoryID ?? '', categoryName: categoryList?[index].categoryName ?? '', teacherID: teacherID, teacherName: teacherName, ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: k50px,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: const BorderRadius.all(Radius.circular(k20px))
                            ),
                            child: Center(child: EasyTextWidget(text: categoryList?[index].categoryName ?? '', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)),
                          ),
                        ),
                        separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k15px),
                        itemCount: categoryList?.length ?? 0
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: (){
              context.navigateToNextScreenReplace(context, CreateCategoryPage(teacher:  teacher,));
            },
            child: Icon(Icons.add, color: kWhite, size: k25px,),
        ),
      ),
    );
  }
}
