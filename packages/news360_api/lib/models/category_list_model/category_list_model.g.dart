// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'category_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) {
  return $checkedNew('CategoryList', json, () {
    final val = CategoryList(
      response: $checkedConvert(
          json,
          'response',
          (v) => (v as List<dynamic>)
              .map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList()),
      statusCode: $checkedConvert(json, 'status_code', (v) => v as String),
      msg: $checkedConvert(json, 'msg', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'statusCode': 'status_code'});
}

Map<String, dynamic> _$CategoryListToJson(CategoryList instance) =>
    <String, dynamic>{
      'response': instance.response,
      'status_code': instance.statusCode,
      'msg': instance.msg,
    };
