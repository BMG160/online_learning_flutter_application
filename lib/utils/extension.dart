import 'package:flutter/material.dart';

extension NavigationEntension on BuildContext{
  Future navigateToNextScreenReplace(BuildContext context, Widget nextScreen) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextScreen));
}