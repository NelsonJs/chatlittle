import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:littelchat/account_page/Login.dart';
import 'package:littelchat/bean/AccountBea.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/util/LoginModel.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:provider/provider.dart';

class Mine extends StatefulWidget {
  @override
  MinePage createState() => MinePage();
}



class MinePage extends State<Mine> {
  String name = "未登录";


  @override
  Widget build(BuildContext context) {
    SpUtils().getString(SpUtils.userName).then((value){
      setState(() {
        name = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
    body: Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('images/p1.jpg'),
                      radius: 30,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                },
              )
          ),
          Divider(height: 1,color: Colors.grey[350]),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),child: Row(
            children: <Widget>[
              Image.asset("images/2.0x/addimg.png",width: 40,height: 40,)
            ],
          )),
          Divider(height: 1,color: Colors.grey[350]),
          Padding(padding:  EdgeInsets.fromLTRB(0, 10, 0, 10),
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
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
            ),),
          Divider(height: 1,color: Colors.grey[350]),
        ],
      )
    ),
    );
  }
}
