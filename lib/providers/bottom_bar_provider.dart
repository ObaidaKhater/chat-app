import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int currentIndex = 0;
  TabController tabController;

  changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    tabController.animateTo(currentIndex);
    notifyListeners();
  }
}
