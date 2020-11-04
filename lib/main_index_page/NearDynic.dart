import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/account_page/account-page.dart';
import 'package:littelchat/active_page/publish_dynamic.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/util/time-utils.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';
import 'package:littelchat/common/widgets/icon_widget.dart';
import 'package:littelchat/main_index_page/dynamic-detail.dart';

class NearDynic extends StatefulWidget {
  @override
  NearDynicPage createState() => NearDynicPage();
}

class NearDynicPage extends State<NearDynic> {
  List<Data> mData = [];
  bool hideLoading = true;
  var iconKeys = <int,GlobalKey<StateIconWidget>>{};
  var fieldMap = <int,bool>{};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('老乡',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5,
          actions: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: Icon(Icons.add),onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishDynamic())).then((value){
                      setState(() {

                      });
                    });

                  },
                  )),
            )
          ]
      ),
      body: FutureBuilder<NearDynamic>(
          future: Net().nearDynamicList(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
                if (snapshot.hasError){
                  return Center(
                    child: Text('服务器出错${snapshot.error.toString()}'),
                  );
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
                            if (mData[index].resimg != null && mData[index].resimg.length > 0){
                              w = img(mData[index].resimg);
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
                                        child: mData[index].avatar == null ? Image.asset((mData[index].gender == 1 ? "images/boy.png":"images/girl.png"),width: 40,height: 40) :
                                        Image.network(mData[index].avatar,width: 40,height: 40,fit: BoxFit.cover,errorBuilder: (context,obj,trace){
                                          print("头像获取失败：${mData[index].gender}");
                                            return Image.asset((mData[index].gender == 1 ? "images/boy.png":"images/girl.png"),width: 40,height: 40);
                                        }),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: Text(mData[index].nickname == null ? "加载中.." : mData[index].nickname,style: TextStyle(fontSize: 15,color: Colors.red))),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(mData[index].title),
                                  ),
                                  Text(mData[index].description == null ? "":mData[index].description),
                                  Container(
                                    child: w,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 25),
                                        child: Text(TimeUtils().chatTime(mData[index].createtime)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: GestureDetector(
                                          child: Row(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.chat,size: 15,),
                                              Container(
                                                child: Text('评论'),
                                                margin: EdgeInsets.only(left: 5),
                                              )
                                            ],
                                          ),
                                          onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DynamicDetail(mData[index].did,data:mData[index],k: iconKeys[index],)));
                                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()));
                                          },
                                        ),
                                        margin: EdgeInsets.only(right: 30,bottom: 10),
                                      ),
                                      Container(
                                        child: GestureDetector(
                                          child: IconWidget(iconKeys[index],mData[index].liked == null ? Icons.favorite_border : mData[index].liked ? Icons.favorite : Icons.favorite_border,mData[index].likenum.toString()),
                                          onTap: () async {
                                             String uid = await SpUtils().getString(SpUtils.uid);
                                             Net().likeDynamic(uid, mData[index].did).then((value){
                                               mData[index].liked = value.data.liked;
                                               mData[index].likenum = value.data.likeNum;
                                               IconData icon;
                                               if (mData[index].liked) {
                                                 icon = Icons.favorite;
                                               } else {
                                                 icon = Icons.favorite_border;
                                               }
                                               iconKeys[index].currentState.setIconTxt(icon, mData[index].likenum.toString());
                                             });
                                          },
                                        ),
                                        margin: EdgeInsets.only(right: 30,bottom: 10),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 1,color: Colors.grey[300]),
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
      )
    );
  }

  Widget img(List<String> images){
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: ImageWidget(url: images[0]),
      );
    } else if (images.length == 2) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image.network(images[0],width: 120,height:120),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image.network(images[1],width: 120,height:120),
          )
        ],
      );
    } else {
      return Container();
    }

  }

  Widget empty() {
    return Container();
  }

}