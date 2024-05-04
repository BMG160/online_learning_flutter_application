// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoVO _$VideoVOFromJson(Map<String, dynamic> json) => VideoVO(
      json['video_id'] as String?,
      json['title'] as String?,
      json['thumbnail'] as String?,
      json['video_path'] as String?,
      json['video_duration'] as String?,
    );

Map<String, dynamic> _$VideoVOToJson(VideoVO instance) => <String, dynamic>{
      'video_id': instance.videoID,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'video_path': instance.videoPath,
      'video_duration': instance.videoDuration,
    };
