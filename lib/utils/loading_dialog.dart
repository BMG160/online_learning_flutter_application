import 'package:flutter/material.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';

import '../constant/dimens.dart';

void loadingDialog({
  required BuildContext context,
}){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shadowColor: kBlack,
        backgroundColor: kWhite,
        elevation: 0.0,
        title: EasyTextWidget(text: 'Loading', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),
        content: const SizedBox(
          width: 100,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator()
            ],
          ),
        ),
      )
  );
}