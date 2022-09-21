import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AppModels extends ChangeNotifier {
  bool bottomVisibleOnOff = true;
  bool topVisibleOnOff = true;
  int index = 1;
  void pageViewIndex (int newIndex) {
    index = newIndex;
    notifyListeners();
  }
  void showAndHideTopAndBottomBar() {
    if (topVisibleOnOff) {
      topVisibleOnOff = false;
    }if(bottomVisibleOnOff){
      bottomVisibleOnOff = false;
    }
    else{
      topVisibleOnOff = true;
      bottomVisibleOnOff = true;
    }
    notifyListeners();
  }
  void automaticHideBars(int index){
    if (index == 2){
      if(topVisibleOnOff){
        topVisibleOnOff = false;
      }
      if(bottomVisibleOnOff){
        bottomVisibleOnOff = false;
      }
    }
    notifyListeners();
  }
  void automaticShowBars(int index){
    if (index == 0 || index == 1){
      if(!topVisibleOnOff){
        topVisibleOnOff = true;
      }
    }
    notifyListeners();
  }
  // void automaticallyHideBottomBar (int index) {
  //   if (index == 0){
  //     if(bottomVisibleOnOff){
  //       bottomVisibleOnOff = false;
  //     }if(!topVisibleOnOff){
  //       topVisibleOnOff = true;
  //     }
  //   }
  //   notifyListeners();
  // }
}
