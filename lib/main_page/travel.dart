import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/ConversationBean.dart';
import 'package:littelchat/bean/travel.dart';
import 'package:littelchat/common/travel_page/publish-travel.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/util/time-utils.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';
import 'package:littelchat/message_page/Contact.dart';
import 'package:littelchat/message_page/chat_detail.dart';

class Travel extends StatefulWidget {
  @override
  TravelPage createState() => TravelPage();
}

class TravelPage extends State<Travel> {
  List<TravelData> datas = [];
  String msg;
  bool hideLoading = false;


  @override
  void initState() {
    super.initState();
    _requestData();
  }

  _requestData(){
    Net().getTravels().then((value){
      setState(() {
        hideLoading = true;
        if (value.code == 1) {
          datas.addAll(value.data);
        } else {
          msg = value.msg;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('出行',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5,
        actions: [
          GestureDetector(
            child: Center(
              child: Padding(padding: EdgeInsets.only(right: 14),child: Text('发布'),),
            ),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>PublishTravel()));
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: ListView.builder(
                itemBuilder: (context,index){
                  if (index == 0){
                    return Container(
                      height: 30,
                      width: 1,
                    );
                  }
                  index -= 1;
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('${datas[index].travelType}',style: TextStyle(),),
                                margin: EdgeInsets.only(left: 6),
                              ),
                              Text('${datas[index].startPlace}---->${datas[index].endPlace}'),
                              Text('更多 >  ',style: TextStyle(fontSize: 12,color: Colors.grey),)
                            ],
                          )
                        ),
                        MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,innerIndex){
                                return ziJiaItem(datas[index].travels[innerIndex]);
                              },
                              itemCount: datas[index].travels.length,
                            )),
                      ],
                    ),
                  );
                },
                itemCount: datas.length+1,
            )

            /*CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    height: 45,
                    width: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('自驾',style: TextStyle(),),
                                margin: EdgeInsets.only(left: 6),
                              ),
                              Text('南昌---->福州',style: TextStyle(fontWeight: FontWeight.w500),),
                              Text('更多 >  ',style: TextStyle(fontSize: 12,color: Colors.grey),)
                            ],
                          ),
                        ),
                        MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                return ziJiaItem();
                              },
                              itemCount: 2,
                            )),
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: (){},
                          child: Text('更多'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              side: BorderSide(style: BorderStyle.solid,color: Colors.white)
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )*/,
          ),
          Offstage(
            offstage: msg != null ? false : true,
            child: Center(
              child: Text('$msg'),
            ),
          ),
          Offstage(
            offstage: hideLoading,
            child: Center(
              child: CupertinoActivityIndicator(radius: 8),
            ),
          )
        ],
      )
    );
  }

  Widget ziJiaItem(Travels travels) {
    return Card(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('${travels.title}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                  margin: EdgeInsets.only(bottom: 2),
                ),
                Row(
                    children: [
                      Container(
                        child: Text('集合时间：${TimeUtils().chatTime(travels.starttime)}',style: TextStyle(fontSize: 12,color: Colors.grey),),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text('地点：${travels.driveloc}',style: TextStyle(fontSize: 12,color: Colors.grey)),
                      ),
                    ]
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text('当前人员：${travels.curnum}/${travels.total}'),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Image.asset("images/girl.png",width: 25,height: 25),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,left: 8),
                      child: Image.asset("images/girl.png",width: 25,height: 25),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,left: 8),
                      child: Image.asset("images/girl.png",width: 25,height: 25),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('公告',style: TextStyle(fontWeight: FontWeight.w500),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text('${travels.description}'),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text('资费标准：',style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text('${travels.price}'),
                        )
                      ],
                    ),
                    Expanded(child: Container(width: 0,height: 0)),
                    FlatButton(
                      color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: (){},
                        child:  Text('申请加入'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          side: BorderSide(style: BorderStyle.solid,color: Colors.white)
                      ),

                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}

