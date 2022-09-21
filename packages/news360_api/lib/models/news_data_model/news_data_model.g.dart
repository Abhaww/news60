// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'news_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDataModel _$NewsDataModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('NewsDataModel', json, () {
    final val = NewsDataModel(
      response: $checkedConvert(
          json,
          'response',
          (v) => (v as List<dynamic>)
              .map((e) => NewsData.fromJson(e as Map<String, dynamic>))
              .toList()),
      msg: $checkedConvert(json, 'msg', (v) => v as String),
      statusCode: $checkedConvert(json, 'status_code', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'statusCode': 'status_code'});
}

Map<String, dynamic> _$NewsDataModelToJson(NewsDataModel instance) =>
    <String, dynamic>{
      'response': instance.response,
      'status_code': instance.statusCode,
      'msg': instance.msg,
    };
