import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/recoment_users.dart';
import 'package:littelchat/common/util/Net.dart';

class Recomment extends StatefulWidget {
  @override
  RecommentPage createState() => RecommentPage();
}

class RecommentPage extends State<Recomment> with AutomaticKeepAliveClientMixin {
  int count = 0;
  List<Data> mData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<RecomentBean>(
        future: Net().getRecomentUsers(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('${snapshot.error.toString()}');
            } else {
              if (snapshot.data.data != null) {
                mData.clear();
                mData.addAll(snapshot.data.data);
              }
              return ListView.builder(
                  itemCount: mData.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: null,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 15, 10, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                ClipOval(
                                  child: Image.network(mData[index].avatar,width: 40,height: 40,fit: BoxFit.cover),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 0),child: Text(mData[index].nickname,style: TextStyle(fontSize: 15),)),
                                    Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 0),child: Container(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                          child:Text('${mData[index].yearOld}',style: TextStyle(color: Colors.white,fontSize: 12))),
                                      decoration: BoxDecoration(
                                          color: Colors.red[300],
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(8))
                                      ),
                                    )),
                                    Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 0),child: Text('签名：今天天气不错哇',style: TextStyle(color: Colors.grey,fontSize: 12))),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('0.33km',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                Text('.',style: TextStyle(color: Colors.grey,fontSize: 12)),
                                Text('在线',style: TextStyle(color: Colors.grey,fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
          } else {
            return CupertinoActivityIndicator();
          }
        },
      )
    );
  }

  @override
  bool get wantKeepAlive => true;

}