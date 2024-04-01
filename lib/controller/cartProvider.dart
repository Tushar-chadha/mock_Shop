import 'package:flutter/cupertino.dart';

class CartNotifier extends ChangeNotifier {
  int _quantity = 0;
  int get quantityGetter => _quantity;
  set setQuantity(int newQuantity) {
    _quantity = newQuantity;
    notifyListeners();
  }
}
