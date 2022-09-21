// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tag_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagListModel _$TagListModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('TagListModel', json, () {
    final val = TagListModel(
      response: $checkedConvert(
          json,
          'response',
          (v) => (v as List<dynamic>)
              .map((e) => Tags.fromJson(e as Map<String, dynamic>))
              .toList()),
      statusCode: $checkedConvert(json, 'status_code', (v) => v as String),
      msg: $checkedConvert(json, 'msg', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'statusCode': 'status_code'});
}

Map<String, dynamic> _$TagListModelToJson(TagListModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'response': instance.response,
      'msg': instance.msg,
    };
