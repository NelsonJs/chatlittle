import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Love extends StatefulWidget {
  @override
  _StateIndex createState() => _StateIndex();
}

class _StateIndex extends State<Love> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('老乡',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            child: Stack(
              children: <Widget>[
                Icon(Icons.sms),
                Positioned(
                  child: Icon(Icons.fiber_manual_record,size: 3,color: Colors.red,),
                  right: 1,
                  top: 1,
                )
              ],
            ),
            onTap: (){

            },
          )
        ],
      ),
      body: Container(
          color: Color(0xf2f2f2),
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 8,
            itemBuilder: (context,index) => Container(
              padding: EdgeInsets.only(top: 4),
              margin: EdgeInsets.only(bottom: 4),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Expanded(child: Image.network("https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1600929328&di=e6992e3467bb87f3e9d163c1c16018a9&src=http://gss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/14ce36d3d539b6002ac5706de850352ac75cb7e4.jpg",
                          loadingBuilder: (c,w,e){
                            if (e == null) {
                              return w;
                            } else {
                              return CupertinoActivityIndicator(radius:15);
                            }
                          },fit: BoxFit.cover)),
                      Positioned(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10
                            ),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 3,bottom: 3),
                                        child: Text('年龄: 25',style: TextStyle(fontSize: 12,color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 3,bottom: 3),
                                        child: Text('心情: 来一场交流',style: TextStyle(fontSize: 12,color: Colors.grey)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        bottom: 1,
                        left: 10,
                      )
                    ],
                  )
              ),
            ),
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(
                    2, index == 0 ? 2.3 : 2.5),
            crossAxisSpacing: 4,
          )
      ),
//      body: Container(
//        child: ListView.builder(
//          itemCount: 10,
//            itemBuilder: (context,index){
//              return GestureDetector(
//                    child: Stack(
//                      alignment: Alignment.center,
//                      children: <Widget>[
//                        ClipRRect(
//                          borderRadius: BorderRadius.all(Radius.circular(5)),
//                          child: Image.asset("images/p1.jpg"),
//                        ),
//                        BackdropFilter(
//                            filter: ImageFilter.blur(
//                              sigmaX: 10,
//                              sigmaY: 10
//                            ),
//                          child: Container(
//                            color: Colors.white10,
//                            child: Column(
//                              children: <Widget>[
//                                Text('昵称：狐狸'),
//                                Text('年龄：23')
//                              ],
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//              );
//            }
//        ),
//      ),
    );
  }


}