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
  ScrollController scrollController = ScrollController();
  AnimatedCarouselProvider provider;
  var _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    Provider.of<AnimatedCarouselProvider>(context, listen: false).setElevation =
        170.0;
    Provider.of<AnimatedCarouselProvider>(context, listen: false).setIndex = 0;
    _tabController = TabController(vsync: this, length: 2);
    scrollController.addListener(onScroll);
    _onRefreshPage();
    super.initState();
  }

  onScroll() {
    closeTopContainer = scrollController.position.pixels > 100;
    if (closeTopContainer) {
      Provider.of<AnimatedCarouselProvider>(context, listen: false)
          .disableHeight();
    } else {
      Provider.of<AnimatedCarouselProvider>(context, listen: false)
          .enableHeight();
    }
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      print("Load more");
    }
  }

  Future<Null> _onRefreshPage() async {
    _refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2), () {});
    return null;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AnimatedCarouselProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Annimation Opacity Demo",
          style: GoogleFonts.montserrat(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
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
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      onPressed: () {},
                      color: Colors.amber,
                      icon: Icon(
                        Icons.restaurant,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Restaurant",
                        style: TextStyle(color: Colors.white),
                      )),
                  RaisedButton.icon(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      color: Colors.blueAccent,
                      icon: Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                      ),
                      label: Text("Go Shopping",
                          style: TextStyle(color: Colors.white))),
                ],
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
                  RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: _onRefreshPage,
                    child: ListView.builder(
                        controller: scrollController,
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
                  ),
                  ListView.builder(
                      controller: scrollController,
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
