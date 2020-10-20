import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';
import 'package:littelchat/common/widgets/icon_widget.dart';

class DynamicDetail extends StatefulWidget {
  final String did;

  final Data data;
  final GlobalKey<StateIconWidget> k;
  DynamicDetail(this.did, {this.data, this.k});

  @override
  _DynamicDetailState createState() => _DynamicDetailState();
}

class _DynamicDetailState extends State<DynamicDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('详情',
                style: TextStyle(color: Colors.black87, fontSize: 16)),
            elevation: 0.5),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Expanded(child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(widget.data.title),
                        ),
                        Text(widget.data.description == null
                            ? ""
                            : widget.data.description),
                        Container(
                            child: widget.data.resimg != null &&
                                widget.data.resimg.length > 0
                                ? img(widget.data.resimg)
                                : empty()),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat,
                                      size: 15,
                                    ),
                                    Container(
                                      child: Text('评论'),
                                      margin: EdgeInsets.only(left: 5),
                                    )
                                  ],
                                ),
                                onTap: () {},
                              ),
                              margin: EdgeInsets.only(right: 30, bottom: 10),
                            ),
                          ],
                        ),
                        Divider(height: 1, color: Colors.grey[300]),
                      ],
                    )),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      print('index==>' + index.toString());
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(widget.data.comments[index].nickname +
                                    "：" +
                                    widget.data.comments[index].content),
                              ],
                            ),
                            Offstage(
                                offstage: (widget.data.comments[index].reply ==
                                    null ||
                                    widget.data.comments[index].reply.length ==
                                        0)
                                    ? true
                                    : false,
                                child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    color: Colors.grey,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                        widget.data.comments[index].reply ==
                                            null
                                            ? 0
                                            : widget.data.comments[index].reply
                                            .length,
                                        itemBuilder: (context, i) {
                                          return Row(
                                            children: [
                                              Text(widget.data.comments[index]
                                                  .reply[i].nickname +
                                                  ">" +
                                                  widget.data.comments[index]
                                                      .reply[i].replynickname +
                                                  ":" +
                                                  widget.data.comments[index]
                                                      .reply[i].content)
                                            ],
                                          );
                                        }))),
                          ],
                        ),
                      );
                    },
                        childCount: widget.data.comments == null
                            ? 0
                            : widget.data.comments.length))
              ],
            )),
            Positioned(
                
                child: Container(
                  color: Colors.red,
                  child: Row(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: '评论',
                          contentPadding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                        ),
                      ),

                      /*Row(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '评论',
                      contentPadding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 15),
                    child: GestureDetector(
                      child: Text("发送"),
                      onTap: (){

                      },
                    ),
                  )
                ],
              )*/
                    ],
                  ),
                )
            ),
          ],
        ));
  }

  Widget empty() {
    return Container();
  }

  Widget img(List<String> images) {
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
}
