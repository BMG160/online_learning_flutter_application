import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPageBloc extends ChangeNotifier{
  late VideoPlayerController _videoController;

  bool _dispose = false;

  bool videoLoading = true;

  bool get isDispose => _dispose;
  bool get isVideoLoading => videoLoading;

  VideoPlayerController get getVideoController => _videoController;

  VideoPageBloc(String videoPath){
    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoPath));

    _videoController.initialize().then((value) {
      _videoController.play();
      videoLoading = false;
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
    _videoController.dispose();
  }
}