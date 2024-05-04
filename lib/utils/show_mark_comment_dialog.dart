
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/data/vos/assignment_vo/assignment_vo.dart';
import 'package:myanmar_educational/widgets/easy_text_form_field.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';
import 'package:myanmar_educational/widgets/secondary_text_form_field.dart';
import 'package:myanmar_educational/widgets/vertical_spacing_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/dimens.dart';

void showMarkCommentDialog({
  required final AssignmentVO? studentAssignment,
  required BuildContext context,
  required TextEditingController markController,
  required TextEditingController commentController,
  required VoidCallback onPressed,
  bool? d,
}) {
  showDialog(
      context: context,
      barrierDismissible: d ?? false,
      builder: (context) => Card(
        color: kWhite,
        margin: const EdgeInsets.symmetric(vertical: 130, horizontal: k20px),
        semanticContainer: true,
        child: Container(
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: EasyTextWidget(text: "Give marks and comment to students' assignment", textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: k100px,
                    child: EasyTextWidget(text: 'File', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    child: EasyTextWidget(text: '-', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: EasyTextWidget(text: studentAssignment?.fileName ?? '', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
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
                    child: EasyTextWidget(text: 'Uploaded By', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: k50px,
                    child: EasyTextWidget(text: studentAssignment?.uploadedByName ?? '', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
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
                    child: EasyTextWidget(text: 'Uploaded Date', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: k50px,
                    height: k50px,
                    child: EasyTextWidget(text: '-', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: k50px,
                    child: EasyTextWidget(text: studentAssignment?.uploadedDate ?? '', textColor: kBlack, textSize: k15px, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kSecondaryColor), maximumSize: const MaterialStatePropertyAll(Size(k150px, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(k150px, 50.0))),
                      onPressed: (){
                        launchUrl(Uri.parse(studentAssignment?.filePath ?? ''));
                      },
                      child: Text("DOWNLOAD", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kBlack, fontSize: 15, fontWeight: FontWeight.normal)),)
                  ),
                ],
              ),
              const VerticalSpacingWidget(h: k20px),
              SecondaryTextFormField(controller: markController, textInputType: TextInputType.number, textInputAction: TextInputAction.next, hintText: 'Enter Marks Here...'),
              const VerticalSpacingWidget(h: k20px),
              SecondaryTextFormField(controller: commentController, textInputType: TextInputType.multiline, textInputAction: TextInputAction.next, hintText: 'Write Comment Here...'),
              const VerticalSpacingWidget(h: k20px),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green), maximumSize: MaterialStatePropertyAll(Size(k150px, 50.0)), minimumSize: MaterialStatePropertyAll(Size(k150px, 50.0))),
                      onPressed: onPressed,
                      child: Text("SUBMIT", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: 15, fontWeight: FontWeight.normal)),)
                  ),
                  const HorizontalSpacingWidget(w: k10px),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kBlack), maximumSize: const MaterialStatePropertyAll(Size(k100px, 50.0)), minimumSize: const MaterialStatePropertyAll(Size(k100px, 50.0))),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("BACK", style: GoogleFonts.gabriela(textStyle: TextStyle(color: kWhite, fontSize: 15, fontWeight: FontWeight.normal)),)
                  ),
                ],
              )
            ],
          ),
        ),
      )
  );
}