import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:littelchat/active_page/publish_love.dart';
import 'package:littelchat/bean/active_bean.dart';
import 'package:littelchat/bean/love_intro.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';

class Find extends StatefulWidget {
  @override
  FindPage createState() => FindPage();
}

class FindPage extends State<Find> with SingleTickerProviderStateMixin{
  List<LoveIntroData> mData = [];
  int t = 0;

  @override
  void initState() {
    super.initState();
    AFutureWidget.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人推荐',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
        actions: <Widget>[
          Center(
            child: GestureDetector(
              child: Container(
                child: Text('发布'),
                margin: EdgeInsets.only(right: 16),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishLovePage()));
              },
            ),
          )
        ],
      ),
        body:AFutureWidget(
          childWidget: _contentWidget(),
          fRefresh: Net().loveIntroList(t),
          onRefreshCallback: (){
            t = 0;
            mData.clear();
            setState(() {});
          },
          fLoading: Net().loveIntroList(t),
          onLoadingCallback: (){
            t = mData.length > 0 ? mData[0].createTime : 0;
            setState(() {});
          },
          dataCallback: (dynamic intro){
            mData.addAll(LoveIntro.fromJson(intro).data);
            print("datacallback--->${mData.length}");
            setState(() {});
          },
        )
    );
  }

  Widget _contentWidget() {
    return  ListView.builder(
        itemCount: mData.length,
        itemBuilder: (context,index){
          return Card(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: ImageWidget(url: mData[index].img),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('姓名：${mData[index].nickname}')),
                    Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('性别：${mData[index].gender == 1 ? "男" : "女"}')),
                    Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('爱好：${mData[index].habit}')),
                    Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('当前位置：${mData[index].curLocal}')),
                  ],
                )
            ),
          );
        });
  }

  /*FutureBuilder<LoveIntro>(
                future: Net().loveIntroList(),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError){
                      return Text('${snapshot.error.toString()}');
                    } else {
                      if (snapshot.data.data != null) {
                        mData.clear();
                        mData.addAll(snapshot.data.data);
                      }
                      return  ListView.builder(
                          itemCount: mData.length,
                          itemBuilder: (context,index){
                            return Card(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //  Text(mData[index].title),
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        child: ImageWidget(url: mData[index].img),
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('姓名：${mData[index].nickname}')),
                                      Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('性别：${mData[index].gender == 1 ? "男" : "女"}')),
                                      Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('爱好：${mData[index].habit}')),
                                      Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('当前位置：${mData[index].curLocal}')),
                                    ],
                                  )
                              ),
                            );
                          });
                    }
                  } else {
                    return CupertinoActivityIndicator();
                  }
                })*/
  Future<Null> _refresh() async {
   /*Net().loveIntroList().then((value) {
     if (value != null && value.data != null) {
       setState(() {
         mData.clear();
         mData.addAll(value.data);
       });
     }
   });*/
    setState(() {
      Net().loveIntroList(0);
    });
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