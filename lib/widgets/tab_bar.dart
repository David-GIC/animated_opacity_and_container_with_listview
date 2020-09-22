import 'package:flutter/material.dart';

class TabBarAndTabViewWidget extends StatelessWidget {
  final TabController tabController;
  final Function onRefreshPage;
  final ScrollController scrollController;
  TabBarAndTabViewWidget(
      {this.tabController, this.onRefreshPage, this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          TabBar(
            controller: tabController,
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
              controller: tabController,
              children: [
                RefreshIndicator(
                  onRefresh: onRefreshPage,
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
  }
}
