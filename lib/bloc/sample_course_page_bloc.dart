import 'package:flutter/material.dart';
import 'package:myanmar_educational/data/apply/apply.dart';
import 'package:myanmar_educational/data/apply/apply_impl.dart';

import '../data/vos/video_vo/video_vo.dart';

class SampleCoursePageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  List<VideoVO>? sampleVideoList;

  List<VideoVO>? get getSampleVideoList => sampleVideoList;

  SampleCoursePageBloc(String courseID){
    _apply.getSampleVideoStream(courseID).listen((event) {
      if(event?.isNotEmpty ?? false){
        sampleVideoList = event;
      } else {
        sampleVideoList = null;
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