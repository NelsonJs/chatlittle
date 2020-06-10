import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/active_page/PublishActive.dart';
import 'package:littelchat/active_page/publish_dynamic.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/util/Net.dart';

class NearDynic extends StatefulWidget {
  @override
  NearDynicPage createState() => NearDynicPage();
}

class NearDynicPage extends State<NearDynic> {
  List<Data> mData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NearDynamic>(
          future: Net().nearDynamicList(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
                if (snapshot.hasError){
                  return Text('遇到错误');
                } else {
                  if (snapshot.data.data != null) {
                    mData.clear();
                    mData.addAll(snapshot.data.data);
                  }
                  return ListView.builder(
                      itemCount: mData.length,
                      itemBuilder: (context,index) {
                        Widget w;
                        if (index %2== 0){
                          w = oneImg();
                        } else {
                          w = empty();
                        }
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: AssetImage('images/p1.jpg'),
                                    radius: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: Text('三胖',style: TextStyle(fontSize: 15,color: Colors.red))),
                                      Padding(padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                                child: Text('24',style: TextStyle(color: Colors.white,fontSize: 12)),
                                                decoration: BoxDecoration(
                                                    color: Colors.red[300],
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              Text(mData[index].title),
                              Text(mData[index].desc),
                              Container(
                                child: w,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('18小时前·4.15km·软件园二期·546播放')
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton.icon(onPressed: null, icon: Icon(Icons.message), label: Text('55')),
                                  FlatButton.icon(onPressed: null, icon: Image.asset('images/3.0x/like.png'), label: Text('485'))
                                ],
                              ),
                              Divider(height: 1,color: Colors.grey[300],)
                            ],
                          ),
                        );
                      }
                  );
                }
            } else {
              return Center(child: CupertinoActivityIndicator(radius: 15,),);
            }
          }
      ),floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishDynamic()));
        },
      child: Icon(Icons.add),
        ),
    );
  }

  Widget oneImg(){
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Image.asset(
          'images/q1.jpg'
      ),
    );
  }

  Widget empty() {
    return Container();
  }

}