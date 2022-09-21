import 'package:equatable/equatable.dart';
import 'package:news360_api/models/bookmark_model/bookmark_model.dart';

class BookmarkState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class BookmarkSaveRemoveState extends BookmarkState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookmarkSavedRemovedState extends BookmarkState{
  final Bookmark bookmarked;
  BookmarkSavedRemovedState({required this.bookmarked});
  @override
  // TODO: implement props
  List<Object?> get props => [bookmarked];
}
class ErrorBookmarkState extends BookmarkState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
