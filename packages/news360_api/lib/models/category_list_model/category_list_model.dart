import 'package:json_annotation/json_annotation.dart';
import 'package:news360_api/models/category_list_model/category.dart';
part 'category_list_model.g.dart';

@JsonSerializable()
class CategoryList {
  final List<Category> response;
  final String statusCode;
  final String msg;

  CategoryList({required this.response, required this.statusCode, required this.msg});
  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      _$CategoryListFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryListToJson(this);
}