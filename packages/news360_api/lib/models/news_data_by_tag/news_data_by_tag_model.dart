import 'package:news360_api/models/news_data_model/news_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'news_data_by_tag_model.g.dart';

@JsonSerializable()
class NewsByTag {
  final List<NewsData> response;
  final String statusCode;
  final String msg;

  NewsByTag({required this.response,required this.statusCode,required this.msg});

  factory NewsByTag.fromJson(Map<String, dynamic> json) =>
      _$NewsByTagFromJson(json);
  Map<String, dynamic> toJson() => _$NewsByTagToJson(this);
}