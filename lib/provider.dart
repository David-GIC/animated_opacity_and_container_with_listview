import 'package:flutter/foundation.dart';

class AnimatedCarouselProvider with ChangeNotifier {
  double _carouselHeight;

  get carouselHeight => _carouselHeight;

  set setElevation(double elevation) {
    _carouselHeight = elevation;
  }

  enableHeight() {
    _carouselHeight = 150;
    notifyListeners();
  }

  disableHeight() {
    _carouselHeight = 0;
    notifyListeners();
  }
}
