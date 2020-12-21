import 'dart:io';

import 'package:flutter/material.dart';
import 'package:littelchat/bean/constants.dart';
import 'package:littelchat/common/util/SpUtils.dart';

class SettingPage extends StatefulWidget {
  @override
  StateSetting createState() => StateSetting();
}

class StateSetting extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Constants.SETTING}',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5,
      ),
      body: Container(
        color: Colors.white,
        child:Column(
          children: <Widget>[
            Padding(
              child: Row(
                children: [
                  Text('${Constants.MODIFY_PWD}'),
                  Expanded(child: Container()),
                  Icon(Icons.navigate_next)
                ],
              ),
              padding: EdgeInsets.only(left: 18,top: 12,right: 15,bottom: 12),
            ),
            Divider(height: 1,color: Colors.grey[350]),
            FlatButton(onPressed: (){
              SpUtils().clear().then((value){
                if (value) {
                  exit(1);
                }
                print(value);
              });
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${Constants.LOGOUT}'),
                Icon(Icons.exit_to_app)
              ],
            )),
            Divider(height: 1,color: Colors.grey[350]),
          ],
        ),
      ),
    );
  }
  
}