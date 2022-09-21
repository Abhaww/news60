// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'news_data_by_tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsByTag _$NewsByTagFromJson(Map<String, dynamic> json) {
  return $checkedNew('NewsByTag', json, () {
    final val = NewsByTag(
      response: $checkedConvert(
          json,
          'response',
          (v) => (v as List<dynamic>)
              .map((e) => NewsData.fromJson(e as Map<String, dynamic>))
              .toList()),
      statusCode: $checkedConvert(json, 'status_code', (v) => v as String),
      msg: $checkedConvert(json, 'msg', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'statusCode': 'status_code'});
}

Map<String, dynamic> _$NewsByTagToJson(NewsByTag instance) => <String, dynamic>{
      'response': instance.response,
      'status_code': instance.statusCode,
      'msg': instance.msg,
    };
