import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void addNewsIdWithTime (String newsId){
  Hive.box('newsId').put('id', newsId);
  // int savedHour = TimeOfDay.now().hour;
  // String savingTime = Hive.box('newsId').get('savingTime');
  // if(savingTime.isEmpty){
  //     Hive.box('newsId').put('savingTime', savedHour);
  //     int hoursRemained = 25 - savedHour;
  //     print(hoursRemained);
  //     Hive.box(newsId).put('hoursRemained', hoursRemained);
  //   }
}
void getNewsId () {
   print(Hive.box('newsId').get('id'),);
}
void deleteNewsId (){
  Hive.box('newsId').delete('id');
}