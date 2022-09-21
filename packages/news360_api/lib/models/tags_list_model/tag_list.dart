import 'package:json_annotation/json_annotation.dart';
import 'tags.dart';
part 'tag_list.g.dart';

@JsonSerializable()
class TagListModel{
  final String statusCode;
  final List<Tags> response;
  final String msg;

  TagListModel({required this.response,required this.statusCode,required this.msg});
  factory TagListModel.fromJson(Map<String, dynamic> json) =>
      _$TagListModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagListModelToJson(this);
}

