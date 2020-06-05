import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/LoginModel.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SocketNet.dart';
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
      body:  Container(
        margin: EdgeInsets.only(top: 200),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: TextField(
                controller: _controllerName,
                decoration: InputDecoration(
                  labelText: '用户名',
                  labelStyle: TextStyle(height: 2),
                  contentPadding: EdgeInsets.only(top: 2.0, bottom: -5),//设置文字内容与边框距离
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.blueGrey,
                          style: BorderStyle.solid)),
                  prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(90, 20, 90, 0),
              child: TextField(
                controller: _controllerPwd,
                decoration: InputDecoration(
                  labelText: '密码',
                  labelStyle: TextStyle(height: 2),
                  contentPadding: EdgeInsets.only(top: 2.0, bottom: -5),//设置文字内容与边框距离
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.blueGrey,
                          style: BorderStyle.solid)),
                    prefixIcon: Icon(Icons.lock)
                ),
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0,30,20,0),
                  child: GestureDetector(
                    child: Text('注册'),
                    onTap: (){
                      var login = Net().register(_controllerName.text, _controllerPwd.text);
                      login.then((value)
                      {
                        if (value == null)return;
                        if (value.uid > 0){
                          context.read<LoginModel>().setAccountBean(value);
                          Navigator.pop(context);
                        }
                      }
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,30,90,0),
                  child: GestureDetector(
                    child: Text('登录'),
                    onTap: (){
                      var login = Net().login(_controllerName.text, _controllerPwd.text);
                      login.then((value)
                      {
                        print("value-->${value.msg}");
                        if (value == null)return;
                        if (value.uid > 0){
                          bus.emit("login");
                          context.read<LoginModel>().setAccountBean(value);
                          Navigator.pop(context);
                        }
                      }
                      );
                    },
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

}