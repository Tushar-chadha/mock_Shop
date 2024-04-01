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
        for (int i = 0; i < _shoeSize.length; i++) {
          _shoeSize[i]["isSelected"] = false;
        }
        _shoeSize[i]["isSelected"] = true;
        _finalShoeSize = _shoeSize[i]["size"];
      }
      notifyListeners();
    }
  }

  void unSelectALl() {
    for (int i = 0; i < _shoeSize.length; i++) {
      _shoeSize[i]["isSelected"] = false;

      notifyListeners();
    }
  }

  String _finalShoeSize = "";
  String get finalShoeSizeGetter => _finalShoeSize;
  set setterFinalShoeSize(String newSize) {
    _finalShoeSize = newSize;
    notifyListeners();
  }

  int _quantity = 0;
  int get quantityGetter => _quantity;
  set setQuantity(int newQuantity) {
    _quantity = newQuantity;
    notifyListeners();
  }

  double _rating = 1.0;
  double get rating => _rating;
  void updateRating(double rating) {
    _rating = rating;
    notifyListeners();
  }
}
