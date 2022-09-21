import 'package:json_annotation/json_annotation.dart';
part 'device_id_response.g.dart';

@JsonSerializable()
class DeviceIdResponse {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'device_id')
  final String deviceId;

  const DeviceIdResponse ({required this.deviceId,required this.userId});

  factory DeviceIdResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceIdResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceIdResponseToJson(this);
}