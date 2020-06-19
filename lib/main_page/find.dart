import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/active_page/publish_love.dart';
import 'package:littelchat/bean/active_bean.dart';
import 'package:littelchat/common/util/Net.dart';

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
      body:
      Scaffold(
        body:FutureBuilder<ActiveBean>(
            future: Net().activeList(),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError){
                  return Text('data');
                } else {
                  if (snapshot.data.data != null) {
                   // mData.clear();
                    //mData.addAll(snapshot.data.data);
                  }
                  return  ListView.builder(
                    //  itemCount: mData.length,
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
                                    child: Image.asset(
                                        'images/q1.jpg'
                                    ),
                                  )
                                ],
                              )
                          ),
                        );
                      });
                }
              } else {
                return CupertinoActivityIndicator();
              }
            }),
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