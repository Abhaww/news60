import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'category_description')
  final String categoryDescription;
  final String stato;

  Category({required this.categoryDescription,required this.categoryId, required this.categoryName,required this.stato});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}