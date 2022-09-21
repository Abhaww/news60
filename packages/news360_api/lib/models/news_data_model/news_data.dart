import 'package:json_annotation/json_annotation.dart';


import 'news_tags-model.dart';
part 'news_data.g.dart';

@JsonSerializable()
class NewsData {
  @JsonKey(name: 'news_id')
  final String newsId;
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'news_title')
  final String newsTitle;
  @JsonKey(name: 'news_summary')
  final String newsSummary;
  @JsonKey(name: 'news_link')
  final String newsLink;
  @JsonKey(name: 'image_path')
  final String imagePath;
  @JsonKey(name: 'video_path')
  final String videoPath;
  @JsonKey(name: 'provider')
  final String provider;
  @JsonKey(name: 'provider_image')
  final String providerImage;
  @JsonKey(name: 'date_published')
  final String datePublished;
  @JsonKey(name: 'news_type')
  final String newsType;
  final String stato;
  @JsonKey(name: 'is_bookmark')
  final String isBookmark;
  @JsonKey(name: 'tag_list')
  final List<NewsTags>? tagList;

  NewsData({
    required
    this.isBookmark,
    required
    this.stato,
    required
    this.categoryName,
    required
    this.categoryId,
    required
    this.newsTitle,
    required
    this.datePublished,
    required
    this.imagePath,
    required
    this.newsId,
    required
    this.newsLink,
    required
    this.newsSummary,
    required
    this.newsType,
    required
    this.provider,
    required
    this.providerImage,
    required
    this.tagList,
    required
    this.videoPath,
  });
  factory NewsData.fromJson(Map<String, dynamic> json) =>
      _$NewsDataFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDataToJson(this);
}
