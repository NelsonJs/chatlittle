import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:littelchat/bean/ChatRecordBean.dart';
import 'package:littelchat/bean/MessageBean.dart';
import 'package:littelchat/chat_widgets/MessageWidgets.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SocketNet.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/widgets/SnackBackUtil.dart';

class ChatDetail extends StatefulWidget {
  final String identifier;
  final String nickName;
  final int selfUid;
  final String ctype;

  ChatDetail({this.selfUid,this.identifier,this.nickName,this.ctype});

  @override
  ChatDetailPage createState() => ChatDetailPage(selfUid,identifier,nickName,ctype);
}

class ChatDetailPage extends State<ChatDetail> {
  int selfUid = 0;
  String selfName = "";
  String otherName = "";
  String otherUid;
  String ctype = "";
  List<Data> data = <Data>[];
  TextEditingController _controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  ChatDetailPage(int selfUid, String identifier, String nickName,String ctype){
    otherName = nickName;
    this.selfUid = selfUid;
    this.otherUid = identifier;
    this.ctype = ctype;
  }


  getNetData(){
    Net().recordList(selfUid.toString(), otherUid,ctype).then((value){
      setState(() {
        data.clear();
        data.addAll(value.data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getNetData();
    bus.on("msg", (arg) {
     // print(arg);
      MessageBean b = arg;
      print(b.content);
      Data d = Data(content: b.content,uid: b.sendId,peerid: b.receiveId,msgType: b.msgType);
      data.insert(0, d);
      scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
      setState(() {
      });
    });
    SpUtils().getString(SpUtils.userName).then((value) => selfName = value);
  }

  @override
  void dispose() {
    bus.off("msg");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(otherName,style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 1,
        actions: [
          Center(
            child: Padding(
                padding: EdgeInsets.only(right: 25),
                child: GestureDetector(
                  child: Icon(Icons.settings,size: 20,color: Colors.grey,),onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishDynamic()));
                },
                )),
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          controller: scrollController,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context,index){
                            if (data[index].msgType == 1){
                              print('msgtype = 1');
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${data[index].content}',style: TextStyle(fontSize: 12,color: Colors.grey),)
                                ],
                              );
                            } else {
                              if (int.parse(data[index].uid) == 100){
                                return ItemSelfText(data[index].content);
                              } else {
                                return ItemOtherText(txt: data[index].content,name: otherName);
                              }
                            }

                            //return ItemSelfText(data[index].name);
                          }
                      ),
                    )
                ),
              ),

              Divider(height: 1),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: _buildText(),
              )
            ],
          )
      ),
    );
  }

  Widget _buildText() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: null
                ),
              ),
              Flexible(
                  child: TextField(
                      controller: _controller,
                    onChanged: (String text) {
                        setState(() {
                          print(text);
                        });
                    },
                    decoration: InputDecoration(hintText: '发送'),
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child:  IconButton(
                    icon:  Icon(Icons.send),
                    onPressed: (){
                      setState(() {
                        if (_controller.text == ""){
                            SnackBarUtil().showToast(context, _controller.text);
                            return;
                        }
                        var params = Map();
                        params["Cmd"] = "send";
                        params["Ctype"] = ctype;
                        params["Uid"] = selfUid.toString();
                        params["Nickname"] = selfName;
                        print(selfName);
                        params["PeerUid"] = otherUid;
                        params["Content"] = _controller.text;
                        params["MsgType"] = 2;
                        params["AppId"] = 1;
                        String s = jsonEncode(params);
                        print(s);
                        SocketNet.instance.getWebSocket().sink.add(s);
                        data.insert(0, generateData(selfUid.toString(), otherUid, _controller.text));
                        scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                        _controller.clear();
                      });

                    }),
              )
            ],
          ),
        ));
  }

  Data generateData(String sendId,String receiveId,String content) {
    return Data(content: content,uid: sendId,peerid: receiveId);
  }

}


class Image1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset('images/p1.jpg',width: 100,),
    );
  }


}