import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex; //getter to get index value
  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  } //setter to get index value
}
