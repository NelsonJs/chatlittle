import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/active_page/publish_dynamic.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishDynamic()));
                  },
                  )),
            )
          ]
      ),
      body: FutureBuilder<NearDynamic>(
          future: Net().nearDynamicList(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
                if (snapshot.hasError){
                  return Center(
                    child: Text('服务器出错${snapshot.error.toString()}'),
                  );
                } else {
                  if (snapshot.data.data != null) {
                    mData.clear();
                    mData.addAll(snapshot.data.data);
                  }
                  return ConstrainedBox(constraints: BoxConstraints.expand(),
                   child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ListView.builder(
                          itemCount: mData.length,
                          itemBuilder: (context,index) {
                            Widget w;
                            if (mData[index].resImg != null && mData[index].resImg.length > 0){
                              w = img(mData[index].resImg);
                            } else {
                              w = empty();
                            }
                            if (!iconKeys.containsKey(index)) {
                              iconKeys[index] = GlobalKey();
                            }
                            return Container(
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(16, 20, 10, 0),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ClipOval(
                                        child: mData[index].avatar == null ? Image.asset((mData[index].gender == 1 ? "images/boy.png":"images/girl.png"),width: 40,height: 40) :
                                        Image.network(mData[index].avatar,width: 40,height: 40,fit: BoxFit.cover,errorBuilder: (context,obj,trace){
                                          print("头像获取失败：${mData[index].gender}");
                                            return Image.asset((mData[index].gender == 1 ? "images/boy.png":"images/girl.png"),width: 40,height: 40);
                                        }),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: Text(mData[index].nickname == null ? "加载中.." : mData[index].nickname,style: TextStyle(fontSize: 15,color: Colors.red))),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(mData[index].title),
                                  ),
                                  Text(mData[index].description == null ? "":mData[index].description),
                                  Container(
                                    child: w,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 25),
                                        child: Text('18小时前·软件园二期'),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: GestureDetector(
                                          child: Row(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.chat,size: 15,),
                                              Container(
                                                child: Text('评论'),
                                                margin: EdgeInsets.only(left: 5),
                                              )
                                            ],
                                          ),
                                          onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DynamicDetail(mData[index].did,comments:mData[index].comments)));
                                          },
                                        ),
                                        margin: EdgeInsets.only(right: 30,bottom: 10),
                                      ),
                                      Container(
                                        child: GestureDetector(
                                          child: IconWidget(iconKeys[index],mData[index].liked == null ? Icons.favorite_border : mData[index].liked ? Icons.favorite : Icons.favorite_border,mData[index].like.toString()),
                                          onTap: (){
                                            iconKeys[index].currentState.setIconTxt(Icons.favorite, "52");
                                          },
                                        ),
                                        margin: EdgeInsets.only(right: 30,bottom: 10),
                                      ),
                                    ],
                                  ),
                                  Divider(height: 1,color: Colors.grey[300]),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: mData[index].comments == null ? 0 : mData[index].comments.length,
                                      itemBuilder: (context,i){
                                        print(mData[index].comments[i].ateUid);
                                        return Padding(
                                          padding: EdgeInsets.only(top: 5,bottom: 5),
                                          child: Row(
                                            children: [
                                              Text(mData[index].comments[i].nickname),
                                              Offstage(
                                                offstage: (mData[index].comments[i].ateUid == null || mData[index].comments[i].ateUid == "") ? true:false ,
                                                child: Text('@'+mData[index].comments[i].ateNickname),
                                              ),
                                              Text("："+mData[index].comments[i].content),
                                            ],
                                          ),
                                        );
                                      }
                                  )
                                ],
                              ),
                            );
                          }
                      ),Offstage(
                        offstage: hideLoading,
                        child: CupertinoActivityIndicator(radius: 15),
                      ),
                    ],
                  ),);
                }
            } else {
              return Center(child: CupertinoActivityIndicator(radius: 15,),);
            }
          }
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
            child: ImageWidget(url: images[0]),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: ImageWidget(url: images[1]),
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