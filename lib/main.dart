import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:littelchat/account_page/Login.dart';
import 'package:littelchat/bean/MessageBean.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/LoginModel.dart';
import 'package:littelchat/common/util/SocketNet.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/main_page/index.dart';
import 'package:littelchat/main_page/mine.dart';
import 'package:littelchat/main_page/school.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'main_page/find.dart';
import 'main_page/message.dart';
import 'package:dio/dio.dart';


void main() => runApp(
  ChangeNotifierProvider(create: (_)=>LoginModel(),child:  MyApp(),)
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
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
  final pages = <Widget>[Index(),Message(),Find(),Mine()];
  int curIndex = 0;
  /*void getData() async {
      Response response = await Dio().get("http://192.168.1.6:8080/user/conversations?uid=100");
      print(response.data.toString());
  }*/

  @override
  void initState() {
    super.initState();
    SpUtils().getInt(SpUtils.uid).then((value){
      {
        if (value == null)return;
        if (value > 0){
          var params = Map();
          params["Cmd"] = "login";
          params["Uid"] = value.toString();
          params["content"] = "this is test txt";
          String s = jsonEncode(params);
          SocketNet.instance.getWebSocket().sink.add(s);
        }}
    });
    _channel.stream.listen((event) {
      print(event);
      Map<String,dynamic> d = jsonDecode(event);
      if (d['MsgType'] == 0) {
        bus.emit("msg",MessageBean.fromJson(d));
      }

    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }


  //发送数据
  _sendMessage() {
    _channel.sink.add('data');
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.chat),title: Text('消息')),
          BottomNavigationBarItem(icon: Icon(Icons.find_in_page),title: Text('相亲')),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),title: Text('我的')),
        ],
        currentIndex: curIndex,//设置该行会改变指示器的文字图案颜色
        type: BottomNavigationBarType.fixed,
        onTap: onTapClick,
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
        if (index == 3){//登录
          SpUtils().getInt(SpUtils.uid).then((value){
            if (value != null){
              curIndex = index;
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            }
          });
      } else {
          curIndex = index;
        }
      });
  }

  Widget wholePage() {
    return new Scaffold(
        body: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildButtonColumn(Icons.home, "首页"),
            buildButtonColumn(Icons.chat, "消息"),
            buildButtonColumn(Icons.find_in_page, "发现"),
            buildButtonColumn(Icons.person_outline, "我的"),
          ],
        ),
    );
  }

  /*Widget listTilte(String title) {
    return new ListTile(
      title: new Text(title),
    );
  }*/


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

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
