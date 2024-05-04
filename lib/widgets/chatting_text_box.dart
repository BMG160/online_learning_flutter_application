import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myanmar_educational/constant/colors.dart';

import '../constant/dimens.dart';

class ChattingTextBox extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? hintText;
  final bool? obscureText;
  final bool? visibility;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final bool? readOnly;
  const ChattingTextBox({super.key, required this.controller, required this.textInputType, required this.textInputAction, required this.hintText, this.obscureText, this.visibility, this.onTap, this.suffixIcon, this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      cursorColor: kPrimaryColor,
      style: GoogleFonts.gabriela(textStyle: TextStyle(color: kPrimaryColor, fontSize: k15px, fontWeight: FontWeight.normal)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
          hintText: hintText,
          hintStyle: GoogleFonts.gabriela(textStyle: TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.normal)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black)
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)
          ),
          suffixIcon: suffixIcon
      ),
      onTap: onTap,
    );
  }
}
