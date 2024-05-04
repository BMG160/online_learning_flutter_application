import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/video_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  final String videoPath;
  const VideoPage({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoPageBloc>(
      create: (_) => VideoPageBloc(videoPath),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.arrow_back_ios_new, color: kWhite, size: k25px,)
          ),
        ),
        backgroundColor: Colors.black,
        body: Selector<VideoPageBloc, VideoPlayerController>(
          selector: (_, bloc) => bloc.getVideoController,
          builder: (_, videoController, child) => Selector<VideoPageBloc, bool>(
            selector: (_, bloc) => bloc.isVideoLoading,
            builder: (_, videoLoading, child) => Center(
              child: (videoLoading) ? const Center(child: CircularProgressIndicator(),) : AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              )
            ),
          ),
        ),
      ),
    );
  }
}
