// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      json['message_id'] as String?,
      json['sender_id'] as String?,
      json['message'] as String?,
      json['file_name'] as String?,
      json['file_path'] as String?,
      json['time_stamp'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'message_id': instance.messageID,
      'sender_id': instance.senderID,
      'message': instance.message,
      'file_name': instance.fileName,
      'file_path': instance.filePath,
      'time_stamp': instance.timeStamp,
    };
