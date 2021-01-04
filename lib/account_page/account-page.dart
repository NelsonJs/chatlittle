import 'package:flutter/material.dart';
import 'package:littelchat/common/util/SpUtils.dart';

class AccountPage extends StatefulWidget {
  @override
  _StateAccountPage createState() => _StateAccountPage();
}

class _StateAccountPage extends State<AccountPage> {
  String uid;

  @override
  void initState() {
    super.initState();
    SpUtils().getString(SpUtils.uid).then((value) => uid = value);
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('个人信息'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Text('uid：$uid')
              ],
            )
          ],
        ),
      );
  }

}