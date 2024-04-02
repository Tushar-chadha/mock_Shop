import 'package:flutter/cupertino.dart';

class FavNotifier extends ChangeNotifier {
  bool _isLiked = false;

  bool get likeGetter => _isLiked;

  set likeSetter(bool isLiked) {
    _isLiked = _isLiked ? false : true;
    notifyListeners();
  }
}
