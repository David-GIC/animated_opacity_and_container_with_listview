import 'package:animated_opacity_nasted_scroll/provider.dart';
import 'package:animated_opacity_nasted_scroll/widgets/drawer.dart';
import 'package:animated_opacity_nasted_scroll/widgets/slider.dart';
import 'package:animated_opacity_nasted_scroll/widgets/tab_bar.dart';
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
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

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
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Annimation Opacity Demo",
          style: GoogleFonts.montserrat(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => _key.currentState.openDrawer(),
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
                    child: SliderWidget(
                      provider: provider,
                    )),
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
              TabBarAndTabViewWidget(
                scrollController: scrollController,
                onRefreshPage: _onRefreshPage,
                tabController: _tabController,
              )
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
