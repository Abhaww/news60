import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news360_api/models/tags_list_model/tags.dart';

class TagsEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class FetchTagListEvent extends TagsEvent{
  final String deviceId;
  FetchTagListEvent({required this.deviceId});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceId];
}
class TagsState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LoadingTagsListState extends TagsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedTagsListState extends TagsState{
  final List<Tags> tags;
  LoadedTagsListState({required this.tags});
  @override
  // TODO: implement props
  List<Object?> get props => [tags];
}
class ErrorTagsListState extends TagsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TagListBloc extends Bloc<TagsEvent, TagsState>{
  ApiCalls apiCalls;
  TagListBloc(this.apiCalls) : super(LoadingTagsListState());

  @override
  Stream<TagsState> mapEventToState(TagsEvent event) async*{
    // TODO: implement mapEventToState
    if(event is FetchTagListEvent){
      yield LoadingTagsListState();
      try{
        List<Tags> tags = await apiCalls.getTagList(event.deviceId);
        yield LoadedTagsListState(tags: tags);
      }catch(_){
        yield ErrorTagsListState();
      }
    }
  }
}