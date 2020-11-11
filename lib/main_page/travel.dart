import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/ConversationBean.dart';
import 'package:littelchat/common/util/EventBus.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';
import 'package:littelchat/message_page/Contact.dart';
import 'package:littelchat/message_page/chat_detail.dart';

class Travel extends StatefulWidget {
  @override
  TravelPage createState() => TravelPage();
}

class TravelPage extends State<Travel> {
  List<Data> datas = [];

//  getData() async {
//    ConversationBean userBean = await SpUtils().getString(SpUtils.uid).then((value) => Net().conversations(value.toString()));
//    datas.clear();
//    datas.addAll(userBean.data);
//    setState(() {});
//  }
  double statusBarHeight;
  @override
  void initState() {
    statusBarHeight = MediaQuery.of(context).padding.top;
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: CustomScrollView(
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
        ),
      )
    );
  }

  Widget ziJiaItem() {
    return Card(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: [
                      Text('凯迪拉克一辆'),
                      Container(
                        child: Text('出行时间：15：20'),
                        margin: EdgeInsets.only(left: 20),
                      ),
                      Container(
                        child: Text('地点：SM'),
                        margin: EdgeInsets.only(left: 20),
                      ),
                    ]
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text('当前人员：3/5'),
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
                  child: Text('每人可携带重量物品为5kg，体积不超过长30*高25*宽20的行李'),
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
                          child: Text('资费标准：'),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text('油费AA'),
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

