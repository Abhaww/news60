import 'package:json_annotation/json_annotation.dart';
import 'package:news360_api/models/news_data_model/news_data.dart';
part 'news_data_by_search.g.dart';

@JsonSerializable()
class NewsDataBySearchModel {
  final List<NewsData> response;
  final String statusCode;
  final String msg;

  NewsDataBySearchModel({required this.response,required this.msg,required this.statusCode});

  factory NewsDataBySearchModel.fromJson(Map<String, dynamic> json) =>
      _$NewsDataBySearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDataBySearchModelToJson(this);
}