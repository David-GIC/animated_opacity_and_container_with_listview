import 'package:animated_opacity_nasted_scroll/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            title: GoogleFonts.montserrat(),
            body1: GoogleFonts.montserrat(),
            headline: GoogleFonts.montserrat(),
            caption: GoogleFonts.montserrat()),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
          create: (_) => AnimatedCarouselProvider(), child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool closeTopContainer = false;
  ScrollController controller1 = ScrollController();
  AnimatedCarouselProvider provider;
  @override
  void initState() {
    Provider.of<AnimatedCarouselProvider>(context, listen: false).setElevation =
        150.0;
    _tabController = TabController(vsync: this, length: 2);
    controller1.addListener(onScroll);
    super.initState();
  }

  onScroll() {
    closeTopContainer = controller1.position.pixels > 100;
    if (closeTopContainer) {
      Provider.of<AnimatedCarouselProvider>(context, listen: false)
          .disableHeight();
    } else {
      Provider.of<AnimatedCarouselProvider>(context, listen: false)
          .enableHeight();
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AnimatedCarouselProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Flutter Demo",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0.0 : provider.carouselHeight,
                    child: topContainer()),
              ),
              _tabView()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabView() => Expanded(
        child: Column(
          children: <Widget>[
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    "Tab 1",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text("Tab 2", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                      controller: controller1,
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            margin: EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 16,
                                bottom: index + 1 == 10 ? 100 : 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              'Image ${index + 1}',
                              style: TextStyle(fontSize: 16.0),
                            ));
                      }),
                  ListView.builder(
                      controller: controller1,
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            margin: EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 16,
                                bottom: index + 1 == 10 ? 100 : 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.amber
                                    : Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              'Image ${index + 1}',
                              style: TextStyle(fontSize: 16.0),
                            ));
                      }),
                ],
              ),
            ),
          ],
        ),
      );

  Widget topContainer() {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: provider.carouselHeight,
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(seconds: 2),
      ),
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
    );
  }
}
