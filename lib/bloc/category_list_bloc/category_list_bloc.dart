import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news360_api/models/category_list_model/category.dart';

class CategoryListState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingCategoryListState extends CategoryListState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedCategoryListState extends CategoryListState {
  final List<Category> categories;
  LoadedCategoryListState({required this.categories});
  @override
  // TODO: implement props
  List<Object?> get props => [categories];
}
class ErrorCategoryListState extends CategoryListState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryListEvent extends Equatable{
  
  @override
  // TODO: implement props
    List<Object?> get props => throw UnimplementedError();
}

class GetCategoryListEvent extends CategoryListEvent{
  final String deviceId;
  GetCategoryListEvent({required this.deviceId});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceId];
}

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState>{
  CategoryListBloc(this.apiCalls) : super(LoadingCategoryListState());
  ApiCalls apiCalls;

  @override
  Stream<CategoryListState> mapEventToState(CategoryListEvent event) async*{
    // TODO: implement mapEventToState
    if(event is GetCategoryListEvent){
      yield LoadingCategoryListState();
      try{
        List<Category> categories = await apiCalls.getCategories(event.deviceId);
        yield LoadedCategoryListState(categories: categories);
      }catch(_){
        print(_);
        yield ErrorCategoryListState();
      }
    }
  }



}