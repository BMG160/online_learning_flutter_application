
import 'package:flutter/material.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/widgets/easy_text_form_field.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';

void showOptDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shadowColor: Colors.black,
        backgroundColor: kPrimaryColor,
        title: EasyTextWidget(text: 'Opt Code Verification', textColor: kWhite, textSize: k20px, fontWeight: FontWeight.normal),
        contentPadding: const EdgeInsets.only(left: k20px, top: k40px, right: k20px, bottom: k10px),
        content: EasyTextFormField(controller: codeController, textInputType: TextInputType.number, textInputAction: TextInputAction.done, hintText: 'Enter your sms code here'),
        actions: [
          TextButton(onPressed: onPressed, child: EasyTextWidget(text: 'CONFIRM', textColor: kWhite, textSize: k20px, fontWeight: FontWeight.normal))
        ],
      ),
    
  );
}