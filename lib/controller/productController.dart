import 'package:flutter/cupertino.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  int get activePage => _activePage;

  set activePageIndex(int index) {
    _activePage = index;
    notifyListeners();
  }
}
