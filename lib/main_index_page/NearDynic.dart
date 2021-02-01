import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:littelchat/active_page/publish_dynamic.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/hex-color.dart';
import 'package:littelchat/common/util/time-utils.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';
import 'package:littelchat/common/widgets/gallery.dart';
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
  EasyRefreshController _controller = EasyRefreshController();
  var dropItems = [DropdownMenuItem(child: Text('谢家滩'),value: "谢家滩")];

  DateTime _dateTime;

  int offsetTime = 0;
  int limit = 8;

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
                      print(value);
                      if (value != null && value){
                        _controller.callRefresh();
                      }
                    });

                  },
                  )),
            )
          ]
      ),
      body: EasyRefresh.custom(
        controller: _controller,
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        header: ClassicalHeader(
          refreshedText: "刷新完成",
          refreshingText: "正在刷新..",
          refreshText: "下拉刷新",
          refreshReadyText: "松开刷新",
          infoText: _infoTextStr
        ),
        footer: ClassicalFooter(
          loadText: "上拉加载",
          loadReadyText: "松开加载",
          loadedText: "加载完成",
          loadingText: "正在加载",
          noMoreText: "没有更多内容啦~",
          infoText: _infoTextStr
        ),
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
          offsetTime = 0;
          NearDynamic nd = await Net().nearDynamicList(offsetTime,limit);
          if (nd != null && nd.data != null) {
            setState(() {
              mData.clear();
              mData.addAll(nd.data);
            });
          }
          _controller.finishRefresh(success: true);
        },
        onLoad: () async {
          if (mData.length > 0) {
            offsetTime = mData[mData.length-1].createtime;
          }
          NearDynamic nd = await Net().nearDynamicList(offsetTime,limit);
          if (nd != null && nd.data.length > 0) {
            print("----------------------------------");
            print(nd.data[0].title);
            setState(() {
              mData.addAll(nd.data);
            });

          }
          _controller.finishLoad(success: true,noMore: false);
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
                       Offstage(
                         child: Container(
                           margin: EdgeInsets.only(top: 20,left: 5),
                           child: Text(mData[index].title),
                         ),
                         offstage: mData[index].title.isEmpty,
                       ),
                       Container(
                         margin: EdgeInsets.only(top: 10),
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
                             margin: EdgeInsets.only(left: 5,bottom: 10,top: 40),
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
                             margin: EdgeInsets.only(bottom: 10,top: 40),
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
                             margin: EdgeInsets.only(bottom: 10,top: 40),
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
        child: GestureDetector(
          child: CachedNetworkImage(
              imageUrl: images[0],width: 300,height: 200,fit: BoxFit.cover,
              placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
              errorWidget: (context, url, error) => Icon(Icons.error)
          ),
          onTap: (){
              jump(images, 0);
            }
        ),
      );
    } else if (images.length == 2) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: GestureDetector(
              child: CachedNetworkImage(
                  imageUrl: images[0],width: 120,height: 120,fit: BoxFit.cover,
                  placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                  errorWidget: (context, url, error) => Icon(Icons.error)
              ),
              onTap: (){
                jump(images, 0);
              },
            )
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: GestureDetector(
                child: CachedNetworkImage(
                    imageUrl: images[1],width: 120,height: 120,fit: BoxFit.cover,
                    placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                    errorWidget: (context, url, error) => Icon(Icons.error)
                ),
                onTap: (){
                  jump(images, 1);
                },
              )
            ),
            margin: EdgeInsets.only(left: 5),
          )
        ],
      );
    } else if (images.length == 3) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: GestureDetector(
              child: CachedNetworkImage(
                  imageUrl: images[0],width: 90,height: 90,fit: BoxFit.cover,
                  placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                  errorWidget: (context, url, error) => Icon(Icons.error)
              ),
              onTap: (){
                jump(images, 0);
              },
            )
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: GestureDetector(
                child: CachedNetworkImage(
                    imageUrl: images[1],width: 90,height: 90,fit: BoxFit.cover,
                    placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                    errorWidget: (context, url, error) => Icon(Icons.error)
                ),
                onTap: (){
                  jump(images, 1);
                },
              )
            ),
            margin: EdgeInsets.only(left: 5),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: GestureDetector(
                child: CachedNetworkImage(
                    imageUrl: images[2],width: 90,height: 90,fit: BoxFit.cover,
                    placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                    errorWidget: (context, url, error) => Icon(Icons.error)
                ),
                onTap: (){
                  jump(images, 2);
                },
              )
            ),
            margin: EdgeInsets.only(left: 5),
          )
        ],
      );
    } else if (images.length == 4) {
      return Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: GestureDetector(
                  child: CachedNetworkImage(
                      imageUrl: images[0],width: 90,height: 90,fit: BoxFit.cover,
                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error)
                  ),
                  onTap: (){
                    jump(images, 0);
                  },
                )
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[1],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 1);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[2],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 2);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[3],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 3);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          )
        ],
      );
    } else if (images.length == 5) {
      return Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: GestureDetector(
                  child: CachedNetworkImage(
                      imageUrl: images[0],width: 90,height: 90,fit: BoxFit.cover,
                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error)
                  ),
                  onTap: (){
                    jump(images, 0);
                  },
                )
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[1],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 1);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[2],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 2);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[3],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 3);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[4],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images,4);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          )
        ],
      );
    } else if (images.length == 6) {
      return Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: GestureDetector(
                  //child: Image.network(images[0],width: 90,height:90,fit: BoxFit.cover),
                  child: CachedNetworkImage(
                    imageUrl: images[0],width: 90,height: 90,fit: BoxFit.cover,
                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error)
                  ),
                  onTap: (){
                    jump(images, 0);
                  },
                )
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[1],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 1);
                    },
                  ),
                ),
                margin: EdgeInsets.only(left: 5),
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[2],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 2);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[3],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 3);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[4],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 4);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[5],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 5);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          )
        ],
      );
    } else if (images.length == 7) {
      return Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: GestureDetector(
                  child: CachedNetworkImage(
                      imageUrl: images[0],width: 90,height: 90,fit: BoxFit.cover,
                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error)
                  ),
                  onTap: (){
                    jump(images, 0);
                  },
                )
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[1],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 1);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[2],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 2);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[3],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 3);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[4],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 4);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[5],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 5);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[6],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 6);
                    },
                  )
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          )
        ],
      );
    } else if (images.length == 8) {
      return Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: GestureDetector(
                  child: CachedNetworkImage(
                      imageUrl: images[0],width: 90,height: 90,fit: BoxFit.cover,
                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error)
                  ),
                  onTap: (){
                    jump(images, 0);
                  },
                )
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[1],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 1);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[2],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 2);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[3],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 3);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[4],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 4);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[5],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 5);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[6],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 6);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[7],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 7);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          )
        ],
      );
    } else if (images.length == 9) {
      return Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: GestureDetector(
                  child: CachedNetworkImage(
                      imageUrl: images[0],width: 90,height: 90,fit: BoxFit.cover,
                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                      errorWidget: (context, url, error) => Icon(Icons.error)
                  ),
                  onTap: (){
                    jump(images, 0);
                  },
                )
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[1],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 1);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[2],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 2);
                    },
                  )
                ),
                margin: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[3],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 3);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[4],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 4);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[5],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 5);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          ),
          Container(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: images[6],width: 90,height: 90,fit: BoxFit.cover,
                        placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                        errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                    onTap: (){
                      jump(images, 6);
                    },
                  )
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[7],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 7);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                          imageUrl: images[8],width: 90,height: 90,fit: BoxFit.cover,
                          placeholder: (context, url) => CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(Icons.error)
                      ),
                      onTap: (){
                        jump(images, 8);
                      },
                    )
                  ),
                  margin: EdgeInsets.only(left: 5),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 5),
          )
        ],
      );
    } else {
      return Container();
    }

  }

  jump(List<String> images,int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Gallery(
          pics: images,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: false ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }

  Widget empty() {
    return Container();
  }

}