import 'package:json_annotation/json_annotation.dart';
part 'bookmark_model.g.dart';

@JsonSerializable()
class Bookmark {
 final String statusCode;
 final String msg;

 Bookmark({required this.statusCode, required this.msg});

 factory Bookmark.fromJson(Map<String, dynamic> json) =>
     _$BookmarkFromJson(json);
 Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}