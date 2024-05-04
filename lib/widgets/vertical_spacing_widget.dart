import 'package:flutter/material.dart';

class VerticalSpacingWidget extends StatelessWidget {
  final double h;
  const VerticalSpacingWidget({super.key, required this.h});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
    );
  }
}
