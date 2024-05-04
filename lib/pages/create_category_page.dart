import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/bloc/create_category_page_bloc.dart';
import 'package:myanmar_educational/data/vos/teacher_vo/teacher_vo.dart';
import 'package:myanmar_educational/widgets/easy_text_form_field.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../widgets/easy_text_widget.dart';

class CreateCategoryPage extends StatelessWidget {
  final TeacherVO? teacher;
  const CreateCategoryPage({super.key, this.teacher});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateCategoryPageBloc>(
        create: (_) => CreateCategoryPageBloc(),
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
                size: k25px,
                color: kWhite,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(kCategoryLogo, width: 300, height: 300,),
                  ),
                  Selector<CreateCategoryPageBloc, TextEditingController>(
                    selector: (_, bloc) => bloc.getNameController,
                    builder: (_, nameController, child) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.55,
                      padding: const EdgeInsets.all(k20px),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(k20px), topRight: Radius.circular(k20px))
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: EasyTextWidget(text: 'Create New Category', textColor: kWhite, textSize: k20px, fontWeight: FontWeight.w600),),
                          const VerticalSpacingWidget(h: k30px),
                          EasyTextWidget(text: 'Category Name', textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                          const VerticalSpacingWidget(h: k10px),
                          EasyTextFormField(controller: nameController, textInputType: TextInputType.text, textInputAction: TextInputAction.done, hintText: 'Enter category name'),
                          const VerticalSpacingWidget(h: k30px),
                          ButtonView(teacher: teacher,)
                        ],
                      ),
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

class ButtonView extends StatelessWidget {
  final TeacherVO? teacher;
  const ButtonView({super.key, this.teacher});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kWhite), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 50.0))),
        onPressed: (){
          context.read<CreateCategoryPageBloc>().createNewCategory(context, teacher);
        },
        child: Text("CREATE", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kPrimaryColor, fontSize: k15px, fontWeight: FontWeight.normal)),)
    );
  }
}

