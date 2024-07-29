import 'package:flutter/material.dart';

class Global extends ChangeNotifier {
  int findJobsIndex = 0;
  int postIndex = 0;
  int mainIndex = 0;

  void setFindJobsIndex(data) {
    findJobsIndex = data;
    notifyListeners();
  }

  void setMainIndex(data) {
    mainIndex = data;
    notifyListeners();
  }

  void setPostIndex(data) {
    postIndex = data;
    notifyListeners();
  }
}
