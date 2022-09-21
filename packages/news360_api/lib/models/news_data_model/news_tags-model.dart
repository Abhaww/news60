import 'package:json_annotation/json_annotation.dart';
part 'news_tags-model.g.dart';

@JsonSerializable()
class NewsTags {
  @JsonKey(name: 'tag_id')
  final String tagId;
  @JsonKey(name: 'tag_name')
  final String tagName;
  @JsonKey(name: 'news_id')
  final String newsId;
  @JsonKey(name: 'news_tag_id')
  final String newsTagId;

  NewsTags({required this.tagId,required this.newsId, required this.tagName, required this.newsTagId});

  factory NewsTags.fromJson(Map<String, dynamic> json) =>
      _$NewsTagsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsTagsToJson(this);
}
