import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateForgetPw();
}

class _StateForgetPw extends State<ForgetPw> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("找回密码"),
       ),
     );
  }

}