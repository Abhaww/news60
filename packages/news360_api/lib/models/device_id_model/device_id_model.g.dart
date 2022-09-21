// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'device_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceIdModel _$DeviceIdModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('DeviceIdModel', json, () {
    final val = DeviceIdModel(
      response: $checkedConvert(
          json,
          'response',
          (v) => v == null
              ? null
              : DeviceIdResponse.fromJson(v as Map<String, dynamic>)),
      msg: $checkedConvert(json, 'msg', (v) => v as String),
      statusCode: $checkedConvert(json, 'status_code', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'statusCode': 'status_code'});
}

Map<String, dynamic> _$DeviceIdModelToJson(DeviceIdModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'msg': instance.msg,
      'response': instance.response,
    };
