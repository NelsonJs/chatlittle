import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/ConversationBean.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/message_page/Contact.dart';
import 'package:littelchat/message_page/chat_detail.dart';

class Travel extends StatefulWidget {
  @override
  TravelPage createState() => TravelPage();
}

class TravelPage extends State<Travel> {
  List<Data> datas = [];

  getData() async {
    ConversationBean userBean = await SpUtils().getString(SpUtils.uid).then((value) => Net().conversations(value.toString()));
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
        title: Text('老乡',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5,
        actions: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: Icon(Icons.add),onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Contact()));
                  },
            )),
          )
        ],
      ),
      body: Container(
        color: Colors.white,

      )
    );
  }

}

