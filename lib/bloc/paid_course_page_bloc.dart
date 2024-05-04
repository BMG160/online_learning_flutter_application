import 'package:flutter/material.dart';

import '../data/apply/apply.dart';
import '../data/apply/apply_impl.dart';
import '../data/vos/video_vo/video_vo.dart';

class PaidCoursePageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  bool get isDispose => _dispose;

  List<VideoVO>? paidVideoList;

  List<VideoVO>? get getPaidVideoList => paidVideoList;

  PaidCoursePageBloc(String courseID){
    _apply.getPaidVideoStream(courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        paidVideoList = event;
      } else {
        paidVideoList = null;
      }
      notifyListeners();
    });
  }

  String formatDuration(double durationInMilliSeconds) {
    int seconds = (durationInMilliSeconds / 1000).floor();
    int hours = (seconds ~/ 3600).floor();
    int minutes = ((seconds % 3600) ~/ 60).floor();
    int remainingSeconds = (seconds % 60);

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
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
