import 'package:equatable/equatable.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news360_api/models/news_data_model/news.dart';
import 'package:news360_api/models/news_data_model/news_data.dart';
class NewsFeedState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialNewsFeedState extends NewsFeedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingNewsFeedState extends NewsFeedState {
@override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedNewsFeedState extends NewsFeedState {
  final List<NewsData> news;
  LoadedNewsFeedState({required this.news});


  @override
  // TODO: implement props
  List<Object?> get props => [news];
}

class ErrorNewsFeedState extends NewsFeedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
