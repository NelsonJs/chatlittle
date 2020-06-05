// 提供五套可选主题色
import 'package:flutter/material.dart';
import 'package:littelchat/bean/AccountBea.dart';
import 'package:littelchat/common/util/SpUtils.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {

  static int appBarHeight = 0;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  static AccountBean accountBean;
  var uid = 0;
  isLogin() async{
      uid = await SpUtils().getInt(SpUtils.uid);
      print("uid等于$uid");
      return uid > 0;
  }
}