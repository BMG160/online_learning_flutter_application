import 'package:flutter/material.dart';
import 'package:myanmar_educational/bloc/paid_course_page_bloc.dart';
import 'package:myanmar_educational/constant/colors.dart';
import 'package:myanmar_educational/constant/dimens.dart';
import 'package:myanmar_educational/data/vos/course_vo/course_vo.dart';
import 'package:myanmar_educational/pages/video_page.dart';
import 'package:myanmar_educational/utils/extension.dart';
import 'package:myanmar_educational/widgets/easy_text_widget.dart';
import 'package:provider/provider.dart';

import '../data/vos/video_vo/video_vo.dart';
import '../widgets/horizontal_spacing_widget.dart';
import '../widgets/vertical_spacing_widget.dart';

class PaidCoursePage extends StatelessWidget {
  final CourseVO course;
  const PaidCoursePage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaidCoursePageBloc>(
      create: (_) => PaidCoursePageBloc(course.courseID ?? ''),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(k20px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EasyTextWidget(text: 'Sample Lecture Videos', textColor: kPrimaryColor, textSize: k20px, fontWeight: FontWeight.normal),
              const VerticalSpacingWidget(h: k20px),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.527,
                child: Selector<PaidCoursePageBloc, List<VideoVO>?>(
                    selector: (_, bloc) => bloc.getPaidVideoList,
                    builder: (_, paidVideoList, child) =>(paidVideoList == null) ? Center(child: EasyTextWidget(text: 'There is no course video', textColor: kPrimaryColor, textSize: k15px, fontWeight: FontWeight.normal),) :
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: (){
                          context.navigateToNextScreenReplace(context, VideoPage(videoPath: paidVideoList[index].videoPath ?? ''));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: k150px,
                          padding: const EdgeInsets.all(k20px),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: const BorderRadius.all(Radius.circular(k20px))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: k150px,
                                height: k150px,
                                child: Stack(
                                  children: [
                                    Positioned.fill(child: Image.network(paidVideoList[index].thumbnail ?? '', fit: BoxFit.fill, loadingBuilder: (context, child, loadingProgress){
                                      if(loadingProgress == null){
                                        return child;
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(color: Colors.white,),
                                        );
                                      }
                                    },)),
                                    Positioned.fill(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [Colors.transparent, Colors.black],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter
                                              )
                                          ),
                                        )
                                    ),
                                    Positioned.fill(child: Icon(Icons.play_circle, color: kWhite, size: k30px,)),
                                  ],
                                ),
                              ),
                              const HorizontalSpacingWidget(w: k20px),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EasyTextWidget(text: "Title: ${paidVideoList[index].title ?? ''}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal),
                                  const VerticalSpacingWidget(h: k5px),
                                  DurationView(duration: paidVideoList[index].videoDuration ?? '')
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const VerticalSpacingWidget(h: k20px),
                      itemCount: paidVideoList.length ?? 0,
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DurationView extends StatelessWidget {
  final String duration;
  const DurationView({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return EasyTextWidget(text: "Duration: ${context.read<PaidCoursePageBloc>().formatDuration(double.parse(duration))}", textColor: kWhite, textSize: k15px, fontWeight: FontWeight.normal)
    ;
  }
}
