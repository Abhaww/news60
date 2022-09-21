import 'package:bloc/bloc.dart';
import 'package:news360_api/models/news_data_model/news_data.dart';
import 'news_feed_events.dart';
import 'news_feed_state.dart';
import 'package:news360_api/api_calls.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  ApiCalls? apiCalls;

  NewsFeedBloc(this.apiCalls)
      : super(InitialNewsFeedState());

  @override
  Stream<NewsFeedState> mapEventToState(NewsFeedEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchNewsDataEvent) {
      yield LoadingNewsFeedState();
      try {
        List<NewsData>? news = await apiCalls!.getNewsData(event.deviceId);
        yield LoadedNewsFeedState(news: news);
      } catch (_) {
        yield ErrorNewsFeedState();
        print(_);
      }
    } else if (event is FetchNewsDataBySearchEvent) {
      yield LoadingNewsFeedState();
      try {
        List<NewsData> news = await apiCalls!.getDataBySearch(
            event.deviceId, event.searchKey);
        yield LoadedNewsFeedState(news: news);
      } catch (_) {
        yield ErrorNewsFeedState();
      }
    } else if (event is FetchNewsDataByTagEvent) {
      yield LoadingNewsFeedState();
      try {
        List<NewsData>? news = await apiCalls!.getDataByTag(
            event.deviceId, event.tagId);
        yield LoadedNewsFeedState(news: news);
      } catch (_) {
        yield ErrorNewsFeedState();
      }
    } else if (event is FetchNewsDataByCategoryEvent) {
      yield LoadingNewsFeedState();
      try {
        List<NewsData>? news = await apiCalls!.getDataByCategory(
            event.deviceId, event.catId);
        yield LoadedNewsFeedState(news: news);
      } catch (_) {
        print(_);
        yield ErrorNewsFeedState();
      }
    }else if(event is GetBookmarkDataEvent){
      yield LoadingNewsFeedState();
      try {
        List<NewsData>? news = await apiCalls!.getBookmarkData(
            event.deviceId, event.userId);
        yield LoadedNewsFeedState(news: news);
      }catch(_){
        print(_);
        yield ErrorNewsFeedState();
      }
    }
  }
}