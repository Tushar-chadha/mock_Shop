import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class FavNotifier extends ChangeNotifier {
  List _fav = [], _id = [];
  final _favBox = Hive.box("fav_box");

  List get fav => _fav;
  List get id => _id;

  Future<void> createFavBox(Map<String, dynamic> newFav) async {
    await _favBox.add(newFav); //cart shared preferences
    getFav();
    notifyListeners();
  }

  getFav() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "name": item["name"],
        "category": item["category"],
        "imgUrl": item["imgUrl"],
        "price": item["price"]
      };
    }).toList();

    _fav = favData.toList();
    _id = _fav.map((item) => item["id"]).toList();
  }

  delFav(int key, ShoeId) {
    _favBox.delete(key);
    id.removeWhere((element) => element == ShoeId);
    fav.removeWhere((element) => element["id"] == ShoeId);
    notifyListeners();
  }

  emptyFavBox() {
    _favBox.clear();
    id.clear();
    fav.clear();
    notifyListeners();
  }
}
