import 'package:flutter/cupertino.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  int get activePage => _activePage;

  set SetActivePage(int index) {
    _activePage = index;
    notifyListeners();
  }

  List<dynamic> _shoeSize = [];
  List<dynamic> get shoeSize => _shoeSize;

  void isToggle(int index) {
    if (index >= 0 && index < _shoeSize.length) {
      _shoeSize[index]["isSelected"] = !_shoeSize[index]["isSelected"];
      notifyListeners();
    }
  }

  set shoeSize(List<dynamic> newSize) {
    _shoeSize = newSize;
    notifyListeners();
  }

  double _rating = 1.0;
  double get rating => _rating;
  void updateRating(double rating) {
    _rating = rating;
    notifyListeners();
  }
}
