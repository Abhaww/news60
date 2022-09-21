import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class STCHomeScreensModel extends ChangeNotifier {
  bool bottomVisibleOnOff = true;
  bool topVisibleOnOff = true;
  int currentIndex = 0;

  void updateIndex (int index){
    currentIndex = index;
    notifyListeners();
  }
  /// Till next version
  // void showAndHideTopAndBottomBar() {
  //   if (topVisibleOnOff) {
  //     topVisibleOnOff = false;
  //   }
  //   if (bottomVisibleOnOff) {
  //     bottomVisibleOnOff = false;
  //   }
  //   else {
  //     topVisibleOnOff = true;
  //     bottomVisibleOnOff = true;
  //   }
  //   notifyListeners();
  // }

  void automaticHideBars(int index) {
    if (index == 1) {
      if (topVisibleOnOff) {
        topVisibleOnOff = false;
      }
      if (bottomVisibleOnOff) {
        bottomVisibleOnOff = false;
      }
    }
    notifyListeners();
  }
  void automaticShowBars(int index) {
    if (index == 0) {
      if (!topVisibleOnOff) {
        topVisibleOnOff = true;
      }
    }
    notifyListeners();
  }
}