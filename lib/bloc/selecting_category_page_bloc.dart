import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';

import '../data/vos/category_vo/category_vo.dart';

class SelectingCategoryPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  List<CategoryVO>? categoryList;

  bool get isDispose => _dispose;
  List<CategoryVO>? get getCategoryList => categoryList;

  SelectingCategoryPageBloc(){
    _apply.getCategoryListStream().listen((event) {
      if(event?.isNotEmpty ?? false){
        categoryList = event;
      }
      notifyListeners();
    });
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