import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:littelchat/account_page/account-page.dart';
import 'package:littelchat/active_page/publish_dynamic.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/util/hex-color.dart';
import 'package:littelchat/common/util/time-utils.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';
import 'package:littelchat/common/widgets/icon_widget.dart';
import 'package:littelchat/main_index_page/dynamic-detail.dart';

class NearDynic extends StatefulWidget {
  @override
  NearDynicPage createState() => NearDynicPage();
}

class NearDynicPage extends State<NearDynic> {
  List<Data> mData = [];
  bool hideLoading = true;
  var iconKeys = <int,GlobalKey<StateIconWidget>>{};
  var fieldMap = <int,bool>{};
  var dropItems = [DropdownMenuItem(child: Text('谢家滩'),value: "谢家滩")];

  DateTime _dateTime;

  int page = 0;
  int limit = 10;

  // 获取更多信息
  String get _infoTextStr {
    _dateTime = DateTime.now();
    String fillChar = _dateTime.minute < 10 ? "0" : "";
    return "更新时间:${_dateTime.hour}:$fillChar${_dateTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton(items: dropItems,icon: Icon(Icons.arrow_right),underline: Container(height: 0,),hint: Text('谢家滩',style: TextStyle(fontSize: 14),),),
        elevation: 0.5,
          actions: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: Icon(Icons.add),onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishDynamic())).then((value){
                      setState(() {

                      });
                    });

                  },
                  )),
            )
          ]
      ),
      body: EasyRefresh.custom(
        header: ClassicalHeader(
          refreshedText: "刷新完成",
          refreshingText: "正在刷新..",
          refreshText: "下拉刷新",
          refreshReadyText: "松开刷新",
          infoText: _infoTextStr
        ),
        /*footer: ClassicalFooter(
          loadText: "上拉加载",
          loadReadyText: "松开加载",
          loadedText: "加载完成",
          loadingText: "正在加载",
          noMoreText: "没有更多内容啦~",
          infoText: _infoTextStr
        ),*/
        firstRefresh: true,
        firstRefreshWidget: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SizedBox(
              height: 200,
              width: 300,
              child: CupertinoActivityIndicator(radius: 8,),
            ),
          ),
        ),
        onRefresh: () async {
          page = 0;
          NearDynamic nd = await Net().nearDynamicList(page,limit);
          if (nd != null) {
            setState(() {
              mData.clear();
              mData.addAll(nd.data);
            });
          }
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (mounted) {

            }
          });
          /*page ++;
          NearDynamic nd = await Net().nearDynamicList(page,limit);
          if (nd != null) {
            setState(() {
             // mData.addAll(nd.data);
            });
          }*/
        },
         slivers: [
           SliverList(
               delegate: SliverChildBuilderDelegate((context,index){
                 Widget w;
                 if (mData[index].resimg != null && mData[index].resimg.length > 0){
                   w = img(mData[index].resimg);
                 } else {
                   w = empty();
                 }
                 if (!iconKeys.containsKey(index)) {
                   iconKeys[index] = GlobalKey();
                 }
                 return Container(
                   color: Colors.white,
                   padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                   child:Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Row(
                         children: <Widget>[
                           ClipOval(
                             child: /*mData[index].avatar == null ? Image.asset((mData[index].gender == 1 ? "images/boy.png":"images/girl.png"),width: 40,height: 40) :
                                        Image.network(mData[index].avatar,width: 40,height: 40,fit: BoxFit.cover,errorBuilder: (context,obj,trace){
                                          print("头像获取失败：${mData[index].gender}");
                                            return Image.asset((mData[index].gender == 1 ? "images/boy.png":"images/girl.png"),width: 40,height: 40);
                                        })*/Icon(Icons.account_circle,size: 40,color: Colors.grey[400],),
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: Text(mData[index].nickname == null ? "加载中.." : mData[index].nickname,style: TextStyle(fontSize: 15,color: HexColor("3e3e3e")))),
                             ],
                           ),
                           Expanded(child: Container()),
                           Container(
                             child: Text(TimeUtils().chatTime(mData[index].createtime),style: TextStyle(fontSize: 12,color: HexColor("3e3e3e")),),
                           )
                         ],
                       ),
                       Container(
                         margin: EdgeInsets.only(top: 20,left: 5,bottom: 40),
                         child: Text(mData[index].title),
                       ),
                       Container(
                         child: w,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Container(
                             child: GestureDetector(
                               child: Row(
                                 children: [
                                   Icon(Icons.share,size: 20,color: HexColor("#9E9E9E")),
                                   Container(
                                     child: Text('49',style: TextStyle(color: HexColor("#3e3e3e"),fontSize: 12)),
                                     margin: EdgeInsets.only(left: 2),
                                   ),

                                 ],
                               ),
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DynamicDetail(mData[index].did,data:mData[index],k: iconKeys[index],)));
                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()));
                               },
                             ),
                             margin: EdgeInsets.only(left: 5,bottom: 10),
                           ),
                           Container(
                             child: GestureDetector(
                               child: Row(
                                 crossAxisAlignment:CrossAxisAlignment.center,
                                 children: [
                                   Icon(Icons.chat_bubble_outline,size: 20,color: HexColor("#9E9E9E")),
                                   Container(
                                     child: Text('952',style: TextStyle(color: HexColor("#3e3e3e"),fontSize: 12)),
                                     margin: EdgeInsets.only(left: 2),
                                   ),


                                 ],
                               ),
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DynamicDetail(mData[index].did,data:mData[index],k: iconKeys[index],)));
                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()));
                               },
                             ),
                             margin: EdgeInsets.only(bottom: 10),
                           ),
                           Container(
                             child: GestureDetector(
                               child: Row(
                                 crossAxisAlignment:CrossAxisAlignment.center,
                                 children: [
                                   Icon(Icons.favorite_border,size: 20,color: HexColor("#9E9E9E")),
                                   Container(
                                     child: Text('5689',style: TextStyle(color: HexColor("#3e3e3e"),fontSize: 12)),
                                     margin: EdgeInsets.only(left: 2),
                                   ),


                                 ],
                               ),
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DynamicDetail(mData[index].did,data:mData[index],k: iconKeys[index],)));
                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()));
                               },
                             ),
                             margin: EdgeInsets.only(bottom: 10),
                           )
                           /*Container(
                                        child: GestureDetector(
                                          child: IconWidget(iconKeys[index],mData[index].liked == null ? Icons.favorite_border : mData[index].liked ? Icons.favorite : Icons.favorite_border,mData[index].likenum.toString()),
                                          onTap: () async {
                                             String uid = await SpUtils().getString(SpUtils.uid);
                                             Net().likeDynamic(uid, mData[index].did).then((value){
                                               mData[index].liked = value.data.liked;
                                               mData[index].likenum = value.data.likeNum;
                                               IconData icon;
                                               if (mData[index].liked) {
                                                 icon = Icons.favorite;
                                               } else {
                                                 icon = Icons.favorite_border;
                                               }
                                               iconKeys[index].currentState.setIconTxt(icon, mData[index].likenum.toString());
                                             });
                                          },
                                        ),
                                        margin: EdgeInsets.only(right: 30,bottom: 10),
                                      ),*/
                         ],
                       ),
                       Divider(height: 1,color: Colors.grey[300]),
                     ],
                   ),
                 );
              },
                 childCount: mData == null ? 0 : mData.length
           )
           )
         ],
      )
    );
  }


  Widget img(List<String> images){
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: ImageWidget(url: images[0]),
      );
    } else if (images.length == 2) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image.network(images[0],width: 120,height:120),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image.network(images[1],width: 120,height:120),
          )
        ],
      );
    } else {
      return Container();
    }

  }

  Widget empty() {
    return Container();
  }

}