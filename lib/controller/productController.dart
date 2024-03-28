import 'package:flutter/cupertino.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  int get activePage => _activePage;

  set SetActivePage(int index) {
    _activePage = index;
    notifyListeners();
  }

  List<dynamic> _shoeSize = [];
  List<dynamic> get getShoeSize => _shoeSize;
  set SetShoeSize(List<dynamic> newSize) {
    _shoeSize = newSize;
    notifyListeners();
  }

  void isToggle(int index) {
    for (int i = 0; i < _shoeSize.length; i++) {
      if (index == i) {
        _shoeSize[i]["isSelected"] = !_shoeSize[index]["isSelected"];
      }
      notifyListeners();
    }
    print("final List is after all selection = ${_shoeSize}");
  }

  void unSelectALl() {
    for (int i = 0; i < _shoeSize.length; i++) {
      _shoeSize[i]["isSelected"] = false;
      print(_shoeSize);
      notifyListeners();
    }
  }

  List _finalShoeSize = [];
  List<dynamic> get finalShoeSizeGetter => _finalShoeSize;
  set setterFinalShoeSize(List<double> newSize) {
    _finalShoeSize = newSize;
    _finalShoeSize.sort();
    notifyListeners();
  }

  double _rating = 1.0;
  double get rating => _rating;
  void updateRating(double rating) {
    _rating = rating;
    notifyListeners();
  }
}
