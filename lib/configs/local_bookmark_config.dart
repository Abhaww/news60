import 'package:hive/hive.dart';

void saveBookmark (String newsId){
  List existingId = Hive.box('bookmark').values.toList();
  if(!existingId.contains(newsId)){
    Hive.box('bookmark').add(newsId);
    print('saved');
  }
}

void removeBookmark (String newsId){
  List existingId = Hive.box('bookmark').values.toList();
  if(existingId.contains(newsId)){
    int index = existingId.indexOf(newsId);
    Hive.box('bookmark').deleteAt(index);
    print('deleted');
  }
}