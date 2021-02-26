import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:littelchat/account_page/Login.dart';
import 'package:littelchat/bean/MessageBean.dart';
import 'package:littelchat/chat/chat_main.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/LoginModel.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SocketNet.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/util/permission.dart';
import 'package:littelchat/main_index_page/NearDynic.dart';
import 'package:littelchat/main_page/love.dart';
import 'package:littelchat/main_page/mine.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
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
        GlobalWidgetsLocalizations.delegate,

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
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '0',
    buildNumber: 'Unknown',
  );
  File _apkFile;


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
    _initNotify();
    _initPackageInfo();
  }

  void _showUpdateDialog(String desc,String url){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('新版本更新',style: TextStyle(fontSize: 15)),
            content: Text('$desc'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消'),
                textColor: Colors.grey,
              ),
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  var permissionUtil = PermissionUtil();
                  permissionUtil.checkStoragePermission().then((value){
                    if (value){ //有权限
                      if (Platform.isIOS){

                      } else {
                        downloadAndroid(url).then((value){
                          _apkFile = value;
                          installApk(_apkFile);
                        });
                      }
                    } else { //没有权限,申请权限
                      permissionUtil.getStoragePermission().then((value){
                        if (value){ //有权限
                          if (Platform.isIOS){

                          } else {
                            downloadAndroid(url).then((value){
                              _apkFile = value;
                              installApk(_apkFile);
                            });
                          }
                        } else {
                          Fluttertoast.showToast(msg: "没有存储权限！");
                        }
                      });
                    }
                  });
                },
                textColor: Colors.blue,
                child: Text('更新'),
              ),
            ],
          );
        });
  }

  _initPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    print("版本号：${info.buildNumber}");
    if (info.buildNumber == "0"){
      Fluttertoast.showToast(msg: "版本号获取不正确");
    } else {
      var channel = "android";
      if (Platform.isIOS){
        channel = "ios";
      }
      Net().getApkUpdate(int.parse(info.buildNumber),channel).then((value){
        _showUpdateDialog(value.data.description,value.data.url);
      });
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  int mIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined,size: 25),title: Text('首页',style: TextStyle(fontSize: 10)),
              activeIcon:Icon(Icons.home,size: 25)),
          BottomNavigationBarItem(icon: Icon(Icons.train_outlined,size: 25),title: Text('出行',style: TextStyle(fontSize: 10)),
              activeIcon:Icon(Icons.train,size: 25)),
          BottomNavigationBarItem(icon: Icon(Icons.all_inclusive_outlined,size: 25),title: Text('相亲',style: TextStyle(fontSize: 10)),
              activeIcon:Icon(Icons.all_inclusive,size: 25)),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline,size: 25),title: Text('信息',style: TextStyle(fontSize: 10)),
              activeIcon:Icon(Icons.mail,size: 25)),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline,size: 25),title: Text('我的',style: TextStyle(fontSize: 10)),
              activeIcon:Icon(Icons.person,size: 25)),
        ],
        currentIndex: curIndex,//设置该行会改变指示器的文字图案颜色
        type: BottomNavigationBarType.fixed,
        onTap: onTapClick,
        selectedItemColor: Colors.black54,
        elevation: 3,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        backgroundColor: Colors.white,
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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  void _initNotify() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);



  }

  //onDidRecieveLocalNotification 这个是IOS端接收到通知所作的处理的方法。
  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // 展示通知内容的 dialog.
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();

            },
          )
        ],
      ),
    );
  }


  //onSelectNotification 是对通知被点击的监听方法，这个参数是可选的
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    //payload 可作为通知的一个标记，区分点击的通知。
    if(payload != null && payload == "complete") {
      installApk(_apkFile);
    }
  }


  Future _showNotification(String content,int total,int cur) async {
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '100', '更新APP通知', '此通知是用来显示更新APP的进度条',
        importance: Importance.max, priority: Priority.high,showProgress: true,maxProgress: total,progress: cur);
    //IOS的通知配置
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);
    //显示通知，其中 0 代表通知的 id，用于区分通知。
    await flutterLocalNotificationsPlugin.show(
        0, 'APP下载', '$content', platformChannelSpecifics,
        payload: 'complete');
  }


  //删除单个通知
  Future _cancelNotification() async {
    //参数 0 为需要删除的通知的id
    await flutterLocalNotificationsPlugin.cancel(0);
  }
//删除所有通知
  Future _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  /// 下载安卓更新包
  Future<File> downloadAndroid(String url) async {
    /// 创建存储文件
    Directory storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir.path;
    File file = new File('$storagePath/hometown.apk');

    if (!file.existsSync()) {
      file.createSync();
    }
    try {
      /// 发起下载请求
      Response response = await Dio().get(url,
          onReceiveProgress: (received, total){
            if (total != -1) {
              //print((received / total * 100).toStringAsFixed(0) + "%");
              _showNotification((received / total * 100).toStringAsFixed(0) + "%",total,received);
            }
          },
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
          ));
      file.writeAsBytesSync(response.data);
      return file;
    } catch (e) {
      print(e);
    }
  }

  /// 安装apk
  Future<Null> installApk(File apkFile) async {
    String _apkFilePath = apkFile.path;

    if (_apkFilePath.isEmpty) {
      print('make sure the apk file is set');
      return;
    }
    _cancelAllNotifications();
    InstallPlugin.installApk(_apkFilePath, "com.travel.littelchat")
        .then((result) {
      print('install apk $result');
    }).catchError((error) {
      print('install apk error: $error');
    });
  }


}


