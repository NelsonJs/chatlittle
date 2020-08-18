import 'package:flutter/material.dart';
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
        title: Text('设置'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(onPressed: (){
            SpUtils().clear().then((value){
              if (value) {

              }
            });
            }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                              Text('退出'),
                              Icon(Icons.exit_to_app)
            ],
          )),
          Divider(height: 1,color: Colors.grey[350]),
        ],
      ),
    );
  }
  
}