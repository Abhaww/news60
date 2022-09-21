import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news360_api/models/bookmark_model/bookmark_model.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState>{
  ApiCalls apiCalls;
  BookmarkBloc(this.apiCalls) : super(BookmarkSaveRemoveState());

  @override
  Stream<BookmarkState> mapEventToState(BookmarkEvent event) async*{
    // TODO: implement mapEventToState
    if(event is SaveBookmarkEvent){
      yield BookmarkSaveRemoveState();
      try{
        Bookmark bookmarked = await apiCalls.saveBookmark(event.deviceId, event.userId, event.newsId);
        yield BookmarkSavedRemovedState(bookmarked: bookmarked);
        print('bookmarked!');
      }catch(_){
        yield ErrorBookmarkState();
      }
    }else if(event is RemoveBookmarkEvent){
      yield BookmarkSaveRemoveState();
      try{
        Bookmark bookmarked = await apiCalls.removeBookmark(event.deviceId, event.userId, event.newsId);
        yield BookmarkSavedRemovedState(bookmarked: bookmarked);
        print('bookmarked!');
      }catch(_){
        yield ErrorBookmarkState();
      }
    }
  }
}