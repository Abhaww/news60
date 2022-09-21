// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'device_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceIdResponse _$DeviceIdResponseFromJson(Map<String, dynamic> json) {
  return $checkedNew('DeviceIdResponse', json, () {
    final val = DeviceIdResponse(
      deviceId: $checkedConvert(json, 'device_id', (v) => v as String),
      userId: $checkedConvert(json, 'user_id', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {'deviceId': 'device_id', 'userId': 'user_id'});
}

Map<String, dynamic> _$DeviceIdResponseToJson(DeviceIdResponse instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'device_id': instance.deviceId,
    };
