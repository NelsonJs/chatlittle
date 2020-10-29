import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _StateAccountPage createState() => _StateAccountPage();
}

class _StateAccountPage extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: Image.asset('images/login_bg.jpg',fit: BoxFit.fill,),
              ),
            )
          ],
        ),
      );
  }

}