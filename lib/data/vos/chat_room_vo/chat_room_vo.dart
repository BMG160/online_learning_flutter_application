
import 'package:json_annotation/json_annotation.dart';

part 'chat_room_vo.g.dart';

@JsonSerializable()
class ChatRoomVO {

  @JsonKey(name: 'user_one')
  String? userOne;

  @JsonKey(name: 'user_two')
  String? userTwo;

  ChatRoomVO(this.userOne, this.userTwo);

  factory ChatRoomVO.fromJson(Map<String, dynamic> json) => _$ChatRoomVOFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomVOToJson(this);
}