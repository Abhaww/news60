import 'package:equatable/equatable.dart';

class NewsFeedEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class FetchNewsDataEvent extends NewsFeedEvent {
  final String? deviceId;
  FetchNewsDataEvent({required this.deviceId});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceId];
}

class FetchNewsDataBySearchEvent extends NewsFeedEvent {
  final String? deviceId;
  final String searchKey;
  FetchNewsDataBySearchEvent({required this.deviceId, required this.searchKey});

  @override
  // TODO: implement props
  List<Object?> get props => [deviceId, searchKey];
}

class FetchNewsDataByTagEvent extends NewsFeedEvent {
  final String? deviceId;
  final String tagId;
  FetchNewsDataByTagEvent({required this.deviceId, required this.tagId});

  @override
  // TODO: implement props
  List<Object?> get props => [deviceId, tagId];
}

class FetchNewsDataByCategoryEvent extends NewsFeedEvent {
  final String? deviceId;
  final String catId;
  FetchNewsDataByCategoryEvent({required this.deviceId, required this.catId});

  @override
  // TODO: implement props
  List<Object?> get props => [deviceId, catId];
}

class GetBookmarkDataEvent extends NewsFeedEvent{
  final String deviceId;
  final String userId;
  GetBookmarkDataEvent({required this.deviceId, required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceId, userId];
}