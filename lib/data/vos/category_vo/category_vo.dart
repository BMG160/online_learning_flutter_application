import 'package:json_annotation/json_annotation.dart';

part 'category_vo.g.dart';

@JsonSerializable()
class CategoryVO{

  @JsonKey(name: 'category_id')
  String? categoryID;

  @JsonKey(name: 'category_name')
  String? categoryName;

  CategoryVO(this.categoryID, this.categoryName);

  factory CategoryVO.fromJson(Map<String, dynamic> json) => _$CategoryVOFromJson(json);

  Map<String, dynamic>toJson() => _$CategoryVOToJson(this);
}