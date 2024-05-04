// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileVO _$FileVOFromJson(Map<String, dynamic> json) => FileVO(
      json['file_id'] as String?,
      json['file_name'] as String?,
      json['file_path'] as String?,
      json['uploaded_date'] as String?,
      json['uploaded_by_id'] as String?,
      json['uploaded_by_name'] as String?,
    );

Map<String, dynamic> _$FileVOToJson(FileVO instance) => <String, dynamic>{
      'file_id': instance.fileID,
      'file_name': instance.fileName,
      'file_path': instance.filePath,
      'uploaded_date': instance.uploadedDate,
      'uploaded_by_id': instance.uploadedByID,
      'uploaded_by_name': instance.uploadedByName,
    };
