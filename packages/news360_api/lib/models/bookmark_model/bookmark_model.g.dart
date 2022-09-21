// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) {
  return $checkedNew('Bookmark', json, () {
    final val = Bookmark(
      statusCode: $checkedConvert(json, 'status_code', (v) => v as String),
      msg: $checkedConvert(json, 'msg', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'statusCode': 'status_code'});
}

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      'status_code': instance.statusCode,
      'msg': instance.msg,
    };
