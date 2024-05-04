import 'package:flutter/material.dart';

class FreeStudentCourseDetailPageBloc extends ChangeNotifier{
  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  bool _dispose = false;

  bool get isDispose => _dispose;

  void changeIndex(int i){
    _selectedIndex = i;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if(!_dispose){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }
}