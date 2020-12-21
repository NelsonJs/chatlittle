import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:littelchat/account_page/Login.dart';
import 'package:littelchat/bean/MessageBean.dart';
import 'package:littelchat/chat/chat_main.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/LoginModel.dart';
import 'package:littelchat/common/util/SocketNet.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/main_index_page/NearDynic.dart';
import 'package:littelchat/main_page/love.dart';
import 'package:littelchat/main_page/mine.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'main_page/find.dart';
import 'main_page/travel.dart';


void main() {
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(ChangeNotifierProvider(create: (_)=>LoginModel(),child:  MyApp()));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('zh', 'CH'), // English
        const Locale('en', 'US')
      ],
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();


}



class HomePageState extends State<HomePage> {
  WebSocketChannel _channel = SocketNet.instance.getWebSocket();
  final data = <String>[];
  final pages = <Widget>[NearDynic(),Travel(),Love(),ChatMain(),Mine()];
  int curIndex = 0;


  @override
  void initState() {
    super.initState();
    SpUtils().getString(SpUtils.uid).then((value){
      {
        if (value == null)return;
        if (int.parse(value) > 0){
          var params = Map();
          params["Cmd"] = "login";
          params["Uid"] = value;
          params["content"] = "this is test txt";
          String s = jsonEncode(params);
          SocketNet.instance.getWebSocket().sink.add(s);
        }}
    });
    _channel.stream.listen((event) {
      //print(event);
      Map<String,dynamic> d = jsonDecode(event);
      bus.emit("msg",MessageBean.fromJson(d));
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  int mIndex = 0;
  @override
  Widget build(BuildContext context) {
    //getData();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 20,),title: Text('首页',style: TextStyle(fontSize: 14),)),
          BottomNavigationBarItem(icon: Icon(Icons.train,size: 20),title: Text('出行',style: TextStyle(fontSize: 14))),
          BottomNavigationBarItem(icon: Image.asset("images/alove.png",width: 20,height: 20,),activeIcon:Image.asset("images/love.png",width: 20,height: 20,),title: Text('相亲',style: TextStyle(fontSize: 14))),
          BottomNavigationBarItem(icon: Image.asset("images/msg.png",width: 20,height: 20,),activeIcon:Image.asset("images/amsg.png",width: 20,height: 20,),title: Text('信息',style: TextStyle(fontSize: 14))),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline,size: 20),title: Text('我的',style: TextStyle(fontSize: 14))),
        ],
        currentIndex: curIndex,//设置该行会改变指示器的文字图案颜色
        type: BottomNavigationBarType.fixed,
        onTap: onTapClick,
        selectedItemColor: Colors.black87,
        elevation: 3,
      ),
      /*  pages[curIndex],*/
      body: IndexedStack(
        index: curIndex,
        children: pages,
      )
    );
  }

  void onTapClick(int index) {
      setState(() {
        if (index == 3 || index == 4){//登录
          SpUtils().getString(SpUtils.uid).then((value){
            print(value);
            if (value != null && value.isNotEmpty){
              curIndex = index;
            } else {
              Future fu = Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              fu.then((value) {
                SpUtils().getString(SpUtils.uid).then((v){
                  if (v != null){
                    curIndex = index;
                  } else {
                    curIndex = 0;
                  }
                });
              });
            }
          });
      } else {
          curIndex = index;
        }
      });
  }


  Column buildButtonColumn(IconData icon,String label) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(icon,color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }

}
