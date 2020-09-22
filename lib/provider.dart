import 'package:flutter/foundation.dart';

class AnimatedCarouselProvider with ChangeNotifier {
  double _carouselHeight;
  int _carouselIndex;

  get carouselHeight => _carouselHeight;
  get carouselIndex => _carouselIndex;

  set setElevation(double elevation) {
    _carouselHeight = elevation;
  }

  set setIndex(int index) {
    _carouselIndex = index;
  }

  onIndexChanged(int index) {
    _carouselIndex = index;
    notifyListeners();
  }

  enableHeight() {
    _carouselHeight = 170;
    notifyListeners();
  }

  disableHeight() {
    _carouselHeight = 0;
    notifyListeners();
  }
}
