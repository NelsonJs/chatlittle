import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/ConversationBean.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/message_page/Contact.dart';
import 'package:littelchat/message_page/chat_detail.dart';

class Message extends StatefulWidget {
  @override
  MessagePage createState() => MessagePage();
}

class MessagePage extends State<Message> {
  List<Data> datas = [];

  getData() async {
    ConversationBean userBean = await SpUtils().getInt(SpUtils.uid).then((value) => Net().conversations(value.toString()));
    datas.clear();
    datas.addAll(userBean.data);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
    bus.on("login", (arg) {
      getData();
    });
  }

  @override
  void dispose() {
    bus.off("login");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('消息',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
        actions: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: Text('通讯录'),onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Contact()));
                  },
            )),
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 15),
        child: ListView.separated(
            itemBuilder: (context,index){

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Item(datas,index),
                onTap: (){
                  var uid = datas[index].uid;
                  var name = datas[index].nickName;
                  SpUtils().getInt(SpUtils.uid).then((value){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatDetail(selfUid:value,identifier: uid,nickName: name)));
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context,int index) =>
                Divider(height: 1,color: Colors.blue,indent: 60,),

            itemCount: datas.length),
      ),
//        body: ListView.builder(
//
//            itemCount: 5,
//            itemBuilder: (context,index){
//              return Item();
//            }
//        )

    );
  }

}

class Item extends StatelessWidget {
  List<Data> datas;
  int index;
  Item(this.datas,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('images/p1.jpg'),
                radius: 25,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("${datas[index].nickName}"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text("哈哈哈哈哈哈哈哈"),
                  ),
                ],
              )
            ],
          ),
      ),
    );
  }

}