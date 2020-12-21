import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/conversation-list.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/util/time-utils.dart';
import 'package:littelchat/message_page/Contact.dart';
import 'package:littelchat/message_page/chat_detail.dart';

class ChatMain extends StatefulWidget {
  @override
  _StateChatMain createState() => _StateChatMain();
}

class _StateChatMain extends State<ChatMain> {
  String uid;
  List<CLData> mData = [];
  @override
  void initState() {
    super.initState();
    SpUtils().getString(SpUtils.uid).then((value) => uid = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('信息',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5,
        actions: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: GestureDetector(
                    child: Text('通讯录',style: TextStyle(fontSize: 14)),onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Contact()));
                  },
                  )),
            )
          ]
      ),
      body: FutureBuilder<ConversationList>(
          future: Net().getConversations(uid.toString()),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if (snapshot.hasError) {
                return Center(
                  child: Text('遇到错误${snapshot.error.toString()}'),
                );
              } else {
                mData.clear();
                mData.addAll(snapshot.data.data);
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: mData.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 15,right: 15,top: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset((mData[index].ctype == "2" ? "images/group.png" : "images/boy.png"),width: 40,height: 40),
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(mData[index].nickname,style: TextStyle(color: Colors.black87,fontSize: 14)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(mData[index].content,style: TextStyle(color: Colors.grey,fontSize: 12)),
                                          )
                                        ],
                                      )
                                  ),
                                  Text(TimeUtils().chatTime(mData[index].createTime),style: TextStyle(color: Colors.grey,fontSize: 12))
                                ],
                              ),
                              Container(
                                child: Divider(height: 1),
                                margin: EdgeInsets.only(top: 5),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {
                          final content = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetail(selfUid: int.parse(mData[index].uid),
                            identifier: mData[index].peerid,nickName: mData[index].nickname,ctype: mData[index].ctype,)));
                          setState(() {
                            mData[mData.length-1].content = content;
                          });
                        },
                      );
                    }
                );
              }
            } else {
              return Center(
                child: CupertinoActivityIndicator(radius: 15),
              );
            }
          }
      ),
    );
  }
}