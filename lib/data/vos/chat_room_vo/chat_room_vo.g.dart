// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomVO _$ChatRoomVOFromJson(Map<String, dynamic> json) => ChatRoomVO(
      json['user_one'] as String?,
      json['user_two'] as String?,
    );

Map<String, dynamic> _$ChatRoomVOToJson(ChatRoomVO instance) =>
    <String, dynamic>{
      'user_one': instance.userOne,
      'user_two': instance.userTwo,
    };
