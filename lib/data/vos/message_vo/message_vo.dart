import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO{

  @JsonKey(name: 'message_id')
  String? messageID;

  @JsonKey(name: 'sender_id')
  String? senderID;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'file_name')
  String? fileName;

  @JsonKey(name: 'file_path')
  String? filePath;

  @JsonKey(name: 'time_stamp')
  String? timeStamp;

  MessageVO(this.messageID, this.senderID, this.message, this.fileName,
      this.filePath, this.timeStamp);

  factory MessageVO.fromJson(Map<String, dynamic> json) => _$MessageVOFromJson(json);

  Map<String, dynamic>toJson() => _$MessageVOToJson(this);
}