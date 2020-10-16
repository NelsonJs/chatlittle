import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:littelchat/account_page/Login.dart';
import 'package:littelchat/account_page/modify_self_info.dart';
import 'package:littelchat/bean/AccountBea.dart';
import 'package:littelchat/chat/PersonDetail.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/setting.dart';
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
        name = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('老乡',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5,
      ),
    body: Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 13, 15),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: ClipOval(
                        child: resultList.length == 0 ? Image.asset('images/p1.jpg',width: 30,height: 30,fit: BoxFit.cover) : Image.memory(uint8list,width: 30,height: 30,fit: BoxFit.cover)
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
                              padding: EdgeInsets.only(left: 5),
                             child: Text('$name'),
                             // child: Text("${context.watch<LoginModel>().accountBean.username}"),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('18325984568',style: TextStyle(fontSize: 12,color: Colors.grey)),
                            )
                          ],
                        )
                    ),
                    Icon(Icons.navigate_next)
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
          Divider(height: 1,color: Colors.grey[350]),
          Padding(padding:  EdgeInsets.fromLTRB(0, 10, 16, 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Row(
                        children: <Widget>[
                          Image.asset('images/dongtai.png',width: 30,height: 30),
                          Padding(padding: EdgeInsets.only(left: 8),child: Text('我的动态'),)
                        ],
                      )),
                      Row(
                        children: <Widget>[
                          Text('3条'),
                          Padding(padding: EdgeInsets.only(left: 8),child:Image.asset('images/next.png'))
                        ],
                      )
                    ],
                  )),
          Divider(height: 1,color: Colors.grey[350]),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 16, 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Row(
                        children: <Widget>[
                          Image.asset('images/active.png',width: 30,height: 30),
                          Padding(padding: EdgeInsets.only(left: 8),child: Text('我的活动'),)
                        ],
                      )),
                      Row(
                        children: <Widget>[
                          Text('7条'),
                          Padding(padding: EdgeInsets.only(left: 8),child:Image.asset('images/next.png'))
                        ],
                      )
                    ],
                  )),
          Divider(height: 1,color: Colors.grey[350]),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 16, 10),
            child: Row(
            children: <Widget>[
              Expanded(child: Row(
                children: <Widget>[
                  Image.asset('images/likeme.png',width: 30,height: 30),
                  Padding(padding: EdgeInsets.only(left: 8),child: Text('喜欢我'),)
                ],
              )),
              Row(
                children: <Widget>[
                  Text('23人'),
                  Padding(padding: EdgeInsets.only(left: 8),child:Image.asset('images/next.png'))
                ],
              )
            ],
          ),),
          Divider(height: 1,color: Colors.grey[350]),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 16, 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Row(
                  children: <Widget>[
                    Image.asset('images/smile.png',width: 30,height: 30),
                    Padding(padding: EdgeInsets.only(left: 8),child: Text('设置心情'),)
                  ],
                )),
                Row(
                  children: <Widget>[
                    Text('未设置'),
                    Padding(padding: EdgeInsets.only(left: 8),child:Image.asset('images/next.png'))
                  ],
                )
              ],
            ),),
          Divider(height: 1,color: Colors.grey[350]),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 16, 10),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingPage()));
              },
              child: Row(
                children: <Widget>[
                  Expanded(child: Row(
                    children: <Widget>[
                      Image.asset('images/setting.png',width: 30,height: 30),
                      Padding(padding: EdgeInsets.only(left: 8),child: Text('设置'),)
                    ],
                  )),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 8),child:Image.asset('images/next.png'))
                    ],
                  )
                ],
              ),
            )),
          Divider(height: 1,color: Colors.grey[350]),
        ],
      )
    ),
    );
  }
}
