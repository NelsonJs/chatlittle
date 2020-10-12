import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/active_page/publish_dynamic.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';
import 'package:littelchat/common/widgets/icon_widget.dart';

class NearDynic extends StatefulWidget {
  @override
  NearDynicPage createState() => NearDynicPage();
}

class NearDynicPage extends State<NearDynic> {
  List<Data> mData = [];
  bool hideLoading = true;
  var iconKeys = <int,GlobalKey<StateIconWidget>>{};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('老乡',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 1,
      ),
      body: FutureBuilder<NearDynamic>(
          future: Net().nearDynamicList(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
                if (snapshot.hasError){
                  return Text('遇到错误${snapshot.error.toString()}');
                } else {
                  if (snapshot.data.data != null) {
                    mData.clear();
                    mData.addAll(snapshot.data.data);
                  }
                  return ConstrainedBox(constraints: BoxConstraints.expand(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ListView.builder(
                          itemCount: mData.length,
                          itemBuilder: (context,index) {
                            Widget w;
                            if (mData[index].resImg.length > 0){
                              w = img(mData[index].resImg);
                            } else {
                              w = empty();
                            }
                            if (!iconKeys.containsKey(index)) {
                              iconKeys[index] = GlobalKey();
                            }
                            return Container(
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(16, 20, 10, 0),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ClipOval(
                                        child: Image.network(mData[index].avatar,width: 40,height: 40,fit: BoxFit.cover,errorBuilder: (context,obj,trace){
                                          print("头像获取失败：${mData[index].gender}");
                                            return Image.asset((mData[index].gender == 1 ? "images/boy.png":"images/girl.png"),width: 40,height: 40);
                                        }),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: Text(mData[index].nickname == null ? "加载中.." : mData[index].nickname,style: TextStyle(fontSize: 15,color: Colors.red))),
                                          Padding(padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                                    child: Text(mData[index].yearOld == 0 ? "年龄被隐藏" : mData[index].yearOld.toString(),style: TextStyle(color: Colors.white,fontSize: 12)),
                                                    decoration: BoxDecoration(
                                                        color: mData[index].gender == 0 ? Colors.grey[300] : mData[index].gender == 1 ? Colors.red[300] : Colors.blue[300],
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
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(mData[index].title),
                                  ),
                                  Text(mData[index].desc),
                                  Container(
                                    child: w,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 25),
                                        child: Text('18小时前·4.15km·软件园二期·546播放'),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: GestureDetector(
                                          child: IconWidget(iconKeys[index],mData[index].liked ? Icons.favorite : Icons.favorite_border,mData[index].like.toString()),
                                          onTap: (){
                                            iconKeys[index].currentState.setIconTxt(Icons.favorite, "52");
                                          },
                                        ),
                                        margin: EdgeInsets.only(right: 30,bottom: 10),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 1,color: Colors.grey[300]),
                                  /*ListView.builder(
                                      itemCount: 6,
                                      itemBuilder: (context,index){
                                          if (index == 0) {
                                            return Text('彭恰恰：很有意思的一个活动');
                                          } else {
                                            return Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text('王美丽：你想去玩吗'),
                                            );
                                          }
                                      }
                                  )*/
                                ],
                              ),
                            );
                          }
                      ),Offstage(
                        offstage: hideLoading,
                        child: CupertinoActivityIndicator(radius: 15),
                      ),
                    ],
                  ),);
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

  Widget img(List<String> images){
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: ImageWidget(url: images[0]),
    );
  }

  Widget empty() {
    return Container();
  }

}