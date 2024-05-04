import 'package:json_annotation/json_annotation.dart';

part 'video_vo.g.dart';

@JsonSerializable()
class VideoVO{

  @JsonKey(name: 'video_id')
  String? videoID;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'thumbnail')
  String? thumbnail;

  @JsonKey(name: 'video_path')
  String? videoPath;

  @JsonKey(name: 'video_duration')
  String? videoDuration;

  VideoVO(this.videoID, this.title, this.thumbnail, this.videoPath,
      this.videoDuration);

  factory VideoVO.fromJson(Map<String, dynamic> json) => _$VideoVOFromJson(json);

  Map<String, dynamic> toJson() => _$VideoVOToJson(this);
}