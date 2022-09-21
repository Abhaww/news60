import 'package:json_annotation/json_annotation.dart';
part 'tags.g.dart';

@JsonSerializable()
class Tags{
  @JsonKey(name: 'tag_name')
  final String tagName;
  @JsonKey(name: 'tag_id')
  final String tagId;
  final String stato;

  Tags({required this.stato,required this.tagId,required this.tagName});

  factory Tags.fromJson(Map<String, dynamic> json) =>
      _$TagsFromJson(json);
  Map<String, dynamic> toJson() => _$TagsToJson(this);
}