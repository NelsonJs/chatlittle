import 'package:flutter/material.dart';
import 'package:littelchat/main_index_page/Active.dart';
import 'package:littelchat/main_index_page/NearDynic.dart';
import 'package:littelchat/main_index_page/Recomment.dart';

class Index extends StatefulWidget {
  @override
  IndexPage createState() => IndexPage();
}

class IndexPage extends State<Index> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  List tabs = ["推荐", "附近动态", "活动"];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex:1,length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildTabBar(),
      ),

      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Recomment(),
          NearDynic(),
          Active()
        ],
      ),
    );
  }

  buildTabBar() {
    Widget tabBar = TabBar(
        tabs: tabs.map((e) => Tab(text: e)).toList(),
        isScrollable: true,
        labelPadding: EdgeInsets.all(12.0),
        //注释该两行，因为会抖动
        unselectedLabelStyle: TextStyle(fontSize: 15),
        labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: Colors.red,
        indicatorWeight: 5.1,
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
    );
    return tabBar;
  }

  @override
  bool get wantKeepAlive => true;

}
