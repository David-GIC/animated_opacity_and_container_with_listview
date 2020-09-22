import 'package:animated_opacity_nasted_scroll/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final AnimatedCarouselProvider provider;
  SliderWidget({this.provider});
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
              enlargeCenterPage: true,
              height: 150,
              autoPlay: true,
              enableInfiniteScroll: true,
              initialPage: 0,
              autoPlayCurve: Curves.easeInOutBack,
              autoPlayAnimationDuration: Duration(seconds: 2),
              onPageChanged: (index, reason) {
                provider.onIndexChanged(index);
              }),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 16, left: 5, right: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Image $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [1, 2, 3, 4, 5].map((url) {
              int index = [1, 2, 3, 4, 5].indexOf(url);
              return FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                child: Container(
                  width: 16.0,
                  height: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: provider.carouselIndex == index
                        ? Colors.blueAccent
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
