import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:littelchat/account_page/forget_pw.dart';
import 'package:littelchat/account_page/register-page.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/LoginModel.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SocketNet.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/widgets/SnackBackUtil.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<Login> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPwd = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ConstrainedBox(constraints: BoxConstraints.expand()),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            height: 150,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.white
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(20, 130, 20, 0),
            child: Container(
              height: 300,
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6))
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextField(
                              controller: _controllerName,
                              decoration: InputDecoration(
                                icon: Icon(Icons.person, size: 25,color: Colors.grey),
                                hintText: '用户名/账号',
                                hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[300],width: 1,style: BorderStyle.solid)),
                              ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextField(
                              controller: _controllerPwd,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock, size: 25,color: Colors.grey,),
                                hintText: '密码',
                                hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[300],width: 1,style: BorderStyle.solid)),
                              ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text('忘记密码？',style: TextStyle(fontSize: 12,color: Colors.blue))
                              ),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgetPw()));
                              },
                            )
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top:20),
                                    child: Builder(
                                        builder: (BuildContext c){
                                          return FlatButton(
                                              onPressed: (){
                                                var login = Net().login(
                                                    _controllerName.text, _controllerPwd.text);
                                                login.then((value) {
                                                  print("value-->${value.msg}");
                                                  if (value == null) return;
                                                  if (value.code == -1) {
                                                    Fluttertoast.showToast(msg: value.msg);
                                                  } else if (value.data.uid != null && value.data.uid.isNotEmpty) {
                                                    SpUtils().saveString(SpUtils.uid, value.data.uid);
                                                    SpUtils().saveString(SpUtils.userName, value.data.nickname);
                                                    bus.emit("login");
                                                    Navigator.pop(c);
                                                  }
                                                });
                                              },
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
                                              color:  Colors.blue,
                                              textColor: Colors.white,
                                              disabledColor:  Colors.blueAccent[100],
                                              focusColor: Colors.blueAccent,
                                              child: Text('登录',style: TextStyle(color: Colors.white))
                                          );
                                        }
                                    )
                                )
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text('没有账号？立即注册',style: TextStyle(fontSize: 12,color: Colors.blue))
                              ),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterPage())).then((value){
                                  if (value != null) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),//end card
          Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Text('----------------------- ',style: TextStyle(fontSize:12,decoration: TextDecoration.none)),
                      Text('第三方登录',style: TextStyle(fontSize:12,decoration: TextDecoration.none)),
                      //Text(' -----------------------',style: TextStyle(fontSize:12,decoration: TextDecoration.none)),
                    ],
                  ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset("images/weChat.png",width: 40,height: 40),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text('微信',style: TextStyle(fontSize: 12),)
                  )
                ],
              )
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
