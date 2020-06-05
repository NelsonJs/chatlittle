import 'package:flutter/material.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';

class Find extends StatefulWidget {
  @override
  FindPage createState() => FindPage();
}

class FindPage extends State<Find> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('相亲',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
      ),
      body:Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.69
            ),
            itemCount: 12,
            itemBuilder: (context,index) {
              return Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ImageWidget.create("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590383366560&di=3064d0bd25e51cc02e1171258de246a4&imgtype=0&src=http%3A%2F%2Fimg1.qunarzz.com%2Ftravel%2Fd3%2F1610%2Fa6%2F407fe6dec93202b5.jpg_r_720x480x95_8f1d73d7.jpg"),
                      Text('标注：吃顿饭就好了~'),
                      Text('升高：156  体重：45kg',style: TextStyle(fontSize: 12,color: Colors.grey[400])), Text('位置：重庆',style: TextStyle(fontSize: 12,color: Colors.grey[400]))
                    ],
                  ),
                ),
              );
            }
        ),
      )
      
    );
  }


//  buildTabBar() {
//    Widget tabBar = TabBar(
//      tabs: tabs.map((e) => Tab(text: e)).toList(),
//      isScrollable: true,
//      labelPadding: EdgeInsets.all(12.0),
//      labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),
//      labelColor: Colors.white,
//      unselectedLabelColor: Colors.white70,
//      indicatorColor: Colors.red,
//      indicatorWeight: 5.1,
//      indicatorSize: TabBarIndicatorSize.label,
//      controller: _tabController,
//    );
//    return tabBar;
//  }

}