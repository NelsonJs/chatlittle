import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:littelchat/account_page/Login.dart';
import 'package:littelchat/account_page/account-page.dart';
import 'package:littelchat/account_page/modify_self_info.dart';
import 'package:littelchat/bean/AccountBea.dart';
import 'package:littelchat/chat/PersonDetail.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/setting.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/LoginModel.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class Mine extends StatefulWidget {
  @override
  MinePage createState() => MinePage();
}



class MinePage extends State<Mine> {
  String name = "未登录";
  List<Asset> resultList = List<Asset>();
  var uint8list;


  Future<void> loadAssets() async {
    resultList.clear();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: resultList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on Exception catch (e) {
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    SpUtils().getInt(SpUtils.uid).then((value) {
      commit(value.toString());
    });
  }

  commit(String uid) async {
    var byteData = await resultList[0].getByteData();
    uint8list = byteData.buffer.asUint8List();
    Net().avatar(uint8list,uid).then((value){
        if (value.code > 0) {
          setState(() {
          });
        }
    });
  }

  @override
  void initState() {
    SpUtils().getString(SpUtils.userName).then((value){
      setState(() {
        if (value.isNotEmpty) {
          name = value;
        }
      });
    });
    super.initState();
    bus.on("login", (arg) {
      SpUtils().getString(SpUtils.userName).then((value){
        setState(() {
          if (value.isNotEmpty) {
            name = value;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('老乡',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0,
      ),
    body: Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 13, 15),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                        child: resultList.length == 0 ? Image.asset('images/p1.jpg',width: 100,height: 115,fit: BoxFit.cover) : Image.memory(uint8list,width: 60,height: 80,fit: BoxFit.cover)
                      ),
                      onTap: (){
                        loadAssets();
                      },
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  Text(name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 25,top: 5),
                                child: GestureDetector(
                                  child: Text('个人资料 >',style: TextStyle(fontSize: 12,color: Colors.grey)),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()));
                                  },
                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 25,top: 15),
                              child:Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('7',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                                      Text('关注',style: TextStyle(fontSize: 10,color: Colors.grey))
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 30),
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('5',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                                          Text('粉丝',style: TextStyle(fontSize: 10,color: Colors.grey))
                                        ],
                                      )
                                  )
                                ],
                              )
                            ),

                          ],
                        )
                    ),
                  ],
                ),
                onTap: (){
                  SpUtils().getInt(SpUtils.uid).then((value) {
                    if (value != null || value > 0) {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonDetail(value)));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ModifyInfoPage()));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    }
                  });
                },
              )
          ),
          Divider(height: 1,color: Colors.grey[300]),
          Container(
            margin: EdgeInsets.only(top: 20,left: 2),
            child: Text('功能',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
          ),
          Container(margin:  EdgeInsets.fromLTRB(0, 10, 16, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset('images/dongtai.png',width: 40,height: 40,fit: BoxFit.contain),
                          Container(child: Text('动态',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('images/likeme.png',width: 40,height: 40,fit: BoxFit.contain),
                          Container(child: Text('点赞'),)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('images/smile.png',width: 40,height: 40,fit: BoxFit.contain),
                          Container(child: Text('心情'),)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('images/comment.png',width: 35,height: 35,fit: BoxFit.contain),
                          Container(child: Text('评论'),)
                        ],
                      ),
                    ],
                  )),
          Container(
            margin: EdgeInsets.only(top: 20,left: 2),
            child: Text('通用',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
          ),
          Container(margin:  EdgeInsets.fromLTRB(0, 10, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      Image.asset('images/share.png',width: 40,height: 40,fit: BoxFit.contain),
                      Container(child: Text('分享',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),)
                    ],
                  ),
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Image.asset('images/setting.png',width: 40,height: 40,fit: BoxFit.contain),
                        Container(child: Text('设置'),)
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingPage()));
                    },
                  ),
                  Placeholder(
                    fallbackWidth: 40,
                    fallbackHeight: 40,
                    strokeWidth: 0,
                    color: Colors.white,
                  ),
                  Placeholder(
                    fallbackWidth: 40,
                    fallbackHeight: 40,
                    strokeWidth: 0,
                    color: Colors.white,
                  )
                ],
              )),
        ],
      )
    ),
    );
  }
}
