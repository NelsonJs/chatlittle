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
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: Text('老乡',style: TextStyle(color: Colors.black87,fontSize: 16)),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('自驾')
                      ],
                    ),
                    Row(
                      children: [
                        Text('南昌---->福州'),
                        Expanded(child: null),
                        Text('更多 >  ')
                      ],
                    ),
                    ListView.builder(
                        itemBuilder: (context,index){
                          return ziJiaItem();
                      },
                      itemCount: 2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget ziJiaItem() {
    return Stack(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('凯迪拉克一辆'),
                    Text('出行时间：15：20'),
                  ]
                )
              ],
            ),
          )
        ],
    );
  }

}

