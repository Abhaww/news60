// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return $checkedNew('Tags', json, () {
    final val = Tags(
      stato: $checkedConvert(json, 'stato', (v) => v as String),
      tagId: $checkedConvert(json, 'tag_id', (v) => v as String),
      tagName: $checkedConvert(json, 'tag_name', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'tagId': 'tag_id', 'tagName': 'tag_name'});
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'tag_name': instance.tagName,
      'tag_id': instance.tagId,
      'stato': instance.stato,
    };
