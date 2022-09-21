import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class Configs extends ChangeNotifier {
 static const darkModeBox = 'Dark Mode On';
 bool darkMode = Hive.box(darkModeBox).get('darkMode', defaultValue: true);

 // void toggleDarkMode (){
 //   Hive.box(darkModeBox).put('darkMode', !darkMode);
 //   notifyListeners();
 // }
 void toggleDarkMode(bool status) {
    final themeBox = Hive.box(darkModeBox);
    themeBox.put('darkMode', status);
   print(themeBox.get('darkMode'));
    darkMode = status;
   notifyListeners();
 }
}