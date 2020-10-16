import 'package:flutter/material.dart';
import 'package:littelchat/chat/PersonDetail.dart';
import 'package:littelchat/message_page/chat_detail.dart';

class Contact extends StatefulWidget {
  @override
  ContactPage createState() => ContactPage();
}

class ContactPage extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('通讯录',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5,
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                padding: EdgeInsets.only(left: 15,top: 10),
                color: Colors.white,
                child: newFriendItem(),
              );
            }
            return item();
          },
          itemCount: 18,
        ),
      ),
    );
  }

  Widget newFriendItem() {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/new_friend.png'),
              radius: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text('新的朋友'),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              height: 1,
              indent: 45,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Widget item() {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('images/p1.jpg'),
                  radius: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('王大锤'), Text('彭大帅')],
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(
                  height: 1,
                  indent: 45,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),

      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonDetail(100)));
      },
    );
  }
}
