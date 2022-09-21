import 'package:equatable/equatable.dart';

class BookmarkEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SaveBookmarkEvent extends BookmarkEvent{
  final String deviceId;
  final String userId;
  final String newsId;
  SaveBookmarkEvent({required this.deviceId, required this.userId, required this.newsId});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceId, userId, newsId];
}

class RemoveBookmarkEvent extends BookmarkEvent{
  final String deviceId;
  final String userId;
  final String newsId;
  RemoveBookmarkEvent({required this.deviceId, required this.userId, required this.newsId});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceId, userId, newsId];
}