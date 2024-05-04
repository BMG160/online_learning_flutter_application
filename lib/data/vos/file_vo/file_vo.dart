import 'package:json_annotation/json_annotation.dart';

part 'file_vo.g.dart';

@JsonSerializable()
class FileVO{

  @JsonKey(name: 'file_id')
  String? fileID;

  @JsonKey(name: 'file_name')
  String? fileName;

  @JsonKey(name: 'file_path')
  String? filePath;

  @JsonKey(name: 'uploaded_date')
  String? uploadedDate;

  @JsonKey(name: 'uploaded_by_id')
  String? uploadedByID;

  @JsonKey(name: 'uploaded_by_name')
  String? uploadedByName;

  FileVO(this.fileID, this.fileName, this.filePath, this.uploadedDate, this.uploadedByID,
      this.uploadedByName);

  factory FileVO.fromJson(Map<String, dynamic> json) => _$FileVOFromJson(json);

  Map<String, dynamic>toJson() => _$FileVOToJson(this);
}