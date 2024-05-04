import 'package:flutter/material.dart';

class HorizontalSpacingWidget extends StatelessWidget {
  final double w;
  const HorizontalSpacingWidget({super.key, required this.w});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
    );
  }
}
