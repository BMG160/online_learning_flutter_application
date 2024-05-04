import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';

void successfulFeedbackSnackBar(BuildContext context, String feedbackMessage){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
              padding: const EdgeInsets.all(k20px),
              height: 80,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(k25px))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(feedbackMessage, style: GoogleFonts.lato(textStyle: TextStyle(color: kWhite, fontSize: k15px, fontWeight: FontWeight.normal, overflow: TextOverflow.fade)),),
                ],
              )
          )
      )
  );
}