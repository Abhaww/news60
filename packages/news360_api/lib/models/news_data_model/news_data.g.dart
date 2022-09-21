// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'news_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsData _$NewsDataFromJson(Map<String, dynamic> json) {
  return $checkedNew('NewsData', json, () {
    final val = NewsData(
      isBookmark: $checkedConvert(json, 'is_bookmark', (v) => v as String),
      stato: $checkedConvert(json, 'stato', (v) => v as String),
      categoryName: $checkedConvert(json, 'category_name', (v) => v as String),
      categoryId: $checkedConvert(json, 'category_id', (v) => v as String),
      newsTitle: $checkedConvert(json, 'news_title', (v) => v as String),
      datePublished:
          $checkedConvert(json, 'date_published', (v) => v as String),
      imagePath: $checkedConvert(json, 'image_path', (v) => v as String),
      newsId: $checkedConvert(json, 'news_id', (v) => v as String),
      newsLink: $checkedConvert(json, 'news_link', (v) => v as String),
      newsSummary: $checkedConvert(json, 'news_summary', (v) => v as String),
      newsType: $checkedConvert(json, 'news_type', (v) => v as String),
      provider: $checkedConvert(json, 'provider', (v) => v as String),
      providerImage:
          $checkedConvert(json, 'provider_image', (v) => v as String),
      tagList: $checkedConvert(
          json,
          'tag_list',
          (v) => (v as List<dynamic>?)
              ?.map((e) => NewsTags.fromJson(e as Map<String, dynamic>))
              .toList()),
      videoPath: $checkedConvert(json, 'video_path', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'isBookmark': 'is_bookmark',
    'categoryName': 'category_name',
    'categoryId': 'category_id',
    'newsTitle': 'news_title',
    'datePublished': 'date_published',
    'imagePath': 'image_path',
    'newsId': 'news_id',
    'newsLink': 'news_link',
    'newsSummary': 'news_summary',
    'newsType': 'news_type',
    'providerImage': 'provider_image',
    'tagList': 'tag_list',
    'videoPath': 'video_path'
  });
}

Map<String, dynamic> _$NewsDataToJson(NewsData instance) => <String, dynamic>{
      'news_id': instance.newsId,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'news_title': instance.newsTitle,
      'news_summary': instance.newsSummary,
      'news_link': instance.newsLink,
      'image_path': instance.imagePath,
      'video_path': instance.videoPath,
      'provider': instance.provider,
      'provider_image': instance.providerImage,
      'date_published': instance.datePublished,
      'news_type': instance.newsType,
      'stato': instance.stato,
      'is_bookmark': instance.isBookmark,
      'tag_list': instance.tagList,
    };
