// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'news_tags-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsTags _$NewsTagsFromJson(Map<String, dynamic> json) {
  return $checkedNew('NewsTags', json, () {
    final val = NewsTags(
      tagId: $checkedConvert(json, 'tag_id', (v) => v as String),
      newsId: $checkedConvert(json, 'news_id', (v) => v as String),
      tagName: $checkedConvert(json, 'tag_name', (v) => v as String),
      newsTagId: $checkedConvert(json, 'news_tag_id', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'tagId': 'tag_id',
    'newsId': 'news_id',
    'tagName': 'tag_name',
    'newsTagId': 'news_tag_id'
  });
}

Map<String, dynamic> _$NewsTagsToJson(NewsTags instance) => <String, dynamic>{
      'tag_id': instance.tagId,
      'tag_name': instance.tagName,
      'news_id': instance.newsId,
      'news_tag_id': instance.newsTagId,
    };
