import 'package:hive/hive.dart';

int lastNewsIndex (List<String> newsIdFetched){
  String lastNewsId = Hive.box('newsId').get('id');
  int index = 0;
  if (lastNewsId != null){
    index = newsIdFetched.indexOf(lastNewsId);
  }
  return index;
}