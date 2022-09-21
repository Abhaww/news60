import 'device_id_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device_id_model.g.dart';

@JsonSerializable()
class DeviceIdModel{
  final String statusCode;
  final String msg;
  final DeviceIdResponse? response;

  DeviceIdModel({required this.response,required this.msg,required this.statusCode});
  factory DeviceIdModel.fromJson(Map<String, dynamic> json) => _$DeviceIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceIdModelToJson(this);
}