import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/widgets/horizontal_spacing_widget.dart';

void feedbackSnackBar(BuildContext context, String feedbackMessage){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(k5px),
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(k25px))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HorizontalSpacingWidget(w: k20px),
              SizedBox(
                width: k30px,
                child: Icon(Icons.warning, color: kWhite, size: k25px,),
              ),
              const HorizontalSpacingWidget(w: k5px),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.6,
                child: Text("Error: $feedbackMessage", style: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal, overflow: TextOverflow.fade)),),
              )
            ],
          )
        )
    )
  );
}