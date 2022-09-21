import 'package:json_annotation/json_annotation.dart';
import 'news_data.dart';
part 'news_data_model.g.dart';

@JsonSerializable()
class NewsDataModel {
  final List<NewsData> response;
  final String statusCode;
  final String msg;
  NewsDataModel({required this.response, required this.msg, required this.statusCode});

  factory NewsDataModel.fromJson(Map<String, dynamic> json) =>
      _$NewsDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDataModelToJson(this);
}