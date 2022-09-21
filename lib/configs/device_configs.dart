import 'package:hive/hive.dart';

void saveDeviceId (String deviceId) {
  String deviceid = Hive.box('deviceInfo').get('deviceId');
  if (deviceid == null){
    Hive.box('deviceInfo').put('deviceId', deviceId);
  }
}

void saveUserId (String userId){
  String userid = Hive.box('deviceInfo').get('userId');
  if(userid == null){
    Hive.box('deviceInfo').put('userId', userId);
  }
}