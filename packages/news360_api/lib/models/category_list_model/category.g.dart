// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return $checkedNew('Category', json, () {
    final val = Category(
      categoryDescription:
          $checkedConvert(json, 'category_description', (v) => v as String),
      categoryId: $checkedConvert(json, 'category_id', (v) => v as String),
      categoryName: $checkedConvert(json, 'category_name', (v) => v as String),
      stato: $checkedConvert(json, 'stato', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'categoryDescription': 'category_description',
    'categoryId': 'category_id',
    'categoryName': 'category_name'
  });
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'category_name': instance.categoryName,
      'category_id': instance.categoryId,
      'category_description': instance.categoryDescription,
      'stato': instance.stato,
    };
