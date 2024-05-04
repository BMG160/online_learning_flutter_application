import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasyTextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;
  final TextDecoration? decoration;
  const EasyTextWidget({super.key, required this.text, required this.textColor, required this.textSize, required this.fontWeight, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.lato(textStyle: TextStyle(color: textColor, fontSize: textSize, fontWeight: fontWeight, decoration: decoration)), overflow: TextOverflow.visible,);
  }
}
