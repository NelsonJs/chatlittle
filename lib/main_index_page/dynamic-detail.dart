import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/util/time-utils.dart';
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
  TextEditingController sendC = TextEditingController();
  FocusNode focusNode = FocusNode();

  _showSnackBar(BuildContext context,String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }
  String mFid = "",mUid = "",mNickname = "",mReplyUid = "",mReplyName = "";
  int mIndex = -1;
  bool isOut = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('详情',
                style: TextStyle(color: Colors.black87, fontSize: 16)),
            elevation: 0.5),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                                child: Text(widget.data.title,style: TextStyle(fontSize: 16)),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  child: widget.data.resimg != null &&
                                      widget.data.resimg.length > 0
                                      ? img(widget.data.resimg)
                                      : empty()),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 25,left: 15,right: 15),
                                    child: Text(TimeUtils().chatTime(widget.data.createtime)),
                                  )
                                ],
                              ),
                              Container(
                                child: Divider(height: 1, color: Colors.grey[300]),
                                margin: EdgeInsets.only(bottom: 10,top: 10),
                              ),
                            ],
                          )),
                      SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            print(widget.data.comments[index]);
                            return Container(
                              margin: EdgeInsets.only(bottom: 15,left: 15,right: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: ClipOval(
                                            child: Image.asset("images/girl.png",width: 30,height: 30)
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Expanded(child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(widget.data.comments[index].comment.nickname,style: TextStyle(fontSize: 12,color: Colors.grey)),
                                                margin: EdgeInsets.only(bottom: 3),
                                              ),
                                              Container(
                                                child: Text(widget.data.comments[index].comment.content),
                                              ),
                                              Container(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Text(TimeUtils().chatTime(widget.data.comments[index].comment.createTime),style: TextStyle(fontSize: 10,color: Colors.grey)),
                                                    ),
                                                    GestureDetector(
                                                      child: Container(
                                                        child: Text('回复',style: TextStyle(fontSize: 10,color: Colors.grey)),
                                                        margin: EdgeInsets.only(left: 20),
                                                      ),
                                                      onTap: () async {
                                                        focusNode.unfocus();
                                                        FocusScope.of(context).requestFocus(focusNode);
                                                        mUid = await SpUtils().getString(SpUtils.uid);
                                                        mNickname = await SpUtils().getString(SpUtils.userName);
                                                        mFid = widget.data.comments[index].comment.cid;
                                                        mReplyUid = widget.data.comments[index].comment.uid;
                                                        mReplyName = widget.data.comments[index].comment.nickname;
                                                        mIndex = index;
                                                        isOut = true;
                                                      },
                                                    )
                                                  ],
                                                ),
                                                margin: EdgeInsets.only(top: 8),
                                              )
                                            ],
                                          )),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(widget.data.comments[index].comment.liked == null ? Icons.favorite_border :
                                              widget.data.comments[index].comment.liked ? Icons.favorite:Icons.favorite_border,color: Colors.grey[350],),
                                              Offstage(
                                                  offstage: widget.data.comments[index].comment.likenum == 0 ? true : false,
                                                  child: Text("${widget.data.comments[index].comment.likenum}",style: TextStyle(fontSize: 14,color: Colors.grey))
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                  Offstage(
                                      offstage: (widget.data.comments[index].comments ==
                                          null ||
                                          widget.data.comments[index].comments.length ==
                                              0)
                                          ? true
                                          : false,
                                      child: Container(
                                          padding: EdgeInsets.only(left: 40),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount:
                                              widget.data.comments[index].comments ==
                                                  null
                                                  ? 0
                                                  : widget.data.comments[index].comments
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child:  Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          child: ClipOval(
                                                              child: Image.asset("images/girl.png",width: 30,height: 30)
                                                          ),
                                                          margin: EdgeInsets.only(right: 10),
                                                        ),
                                                        Expanded(child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  child: Row(
                                                                      children: [
                                                                        Text(widget.data.comments[index].comments[i].nickname,style: TextStyle(fontSize: 12,color: Colors.grey)),
                                                                        Text(' @ ',style: TextStyle(fontSize: 12,color: Colors.grey)),
                                                                        Text(widget.data.comments[index].comments[i].replyname,style: TextStyle(fontSize: 12,color: Colors.grey)),
                                                                      ]
                                                                  ),
                                                                  margin: EdgeInsets.only(bottom: 3),
                                                                ),
                                                                Container(
                                                                  child: Text(widget.data.comments[index].comments[i].content),
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        child: Text(TimeUtils().chatTime(widget.data.comments[index].comments[i].createTime),style: TextStyle(fontSize: 10,color: Colors.grey)),
                                                                      ),
                                                                      GestureDetector(
                                                                        child: Container(
                                                                          child: Text('回复',style: TextStyle(fontSize: 10,color: Colors.grey)),
                                                                          margin: EdgeInsets.only(left: 20),
                                                                        ),
                                                                        onTap: () async {
                                                                          focusNode.unfocus();
                                                                          FocusScope.of(context).requestFocus(focusNode);
                                                                          mUid = await SpUtils().getString(SpUtils.uid);
                                                                          mNickname = await SpUtils().getString(SpUtils.userName);
                                                                          mFid = widget.data.comments[index].comment.cid;
                                                                          mReplyUid = widget.data.comments[index].comments[i].uid;
                                                                          mReplyName = widget.data.comments[index].comments[i].nickname;
                                                                          mIndex = index;
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                  margin: EdgeInsets.only(top: 8),
                                                                )
                                                              ],
                                                            )),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                GestureDetector(
                                                                  child: Icon(widget.data.comments[index].comments[i].liked == null ? Icons.favorite_border :
                                                                  widget.data.comments[index].comments[i].liked ? Icons.favorite:Icons.favorite_border,color: Colors.grey[350]),
                                                                  onTap: () {

                                                                  },
                                                                ),
                                                                Offstage(
                                                                  offstage: widget.data.comments[index].comments[i].likenum == 0 ? true : false,
                                                                  child: Text("${widget.data.comments[index].comments[i].likenum}",style: TextStyle(fontSize: 14,color: Colors.grey))
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ))
                                                      ]
                                                  ),
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
                  )
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Column(
                  children: [
                    Divider(height: 1,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: TextField(
                          focusNode: focusNode,
                          style: TextStyle(fontSize: 14),
                          controller: sendC,
                          decoration: InputDecoration(
                            hintText: '评论..',
                            contentPadding: EdgeInsets.only(top: 2,bottom: 2,left: 15,right: 5),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                          ),
                        )),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Text('评论',style: TextStyle(fontSize: 14,color: Colors.blue),),
                          ),
                          onTap: () {
                            if (mReplyUid.isEmpty) {
                              SpUtils().getString(SpUtils.uid).then((uid) {
                                print("uid--->"+uid);
                                SpUtils().getString(SpUtils.userName).then((name) =>
                                    Net().sendComment(null, widget.data.did, sendC.text, uid, name, null, null).then((value){
                                      setState(() {
                                        var cData = CommentData();
                                        cData.comment = value.data;
                                        widget.data.comments.add(cData);
                                        sendC.text = "";
                                        focusNode.unfocus();
                                      });
                                    })
                                );
                              });
                            } else {
                              Net().sendComment(mFid, widget.data.did, sendC.text, mUid, mNickname,
                                  mReplyUid,mReplyName).then((value) {
                                if (value.code == 1) {
                                  if (widget.data.comments[mIndex].comments == null) {
                                    List<Comment> comments = [];
                                    setState(() {
                                      comments.add(value.data);
                                      widget.data.comments[mIndex].comments = comments;
                                    });
                                  } else {
                                    setState(() {
                                      widget.data.comments[mIndex].comments.add(value.data);
                                    });
                                  }
                                } else {
                                  _showSnackBar(context, value.msg);
                                }
                                mFid = "";
                                mUid = "";
                                mNickname = "";
                                mReplyUid = "";
                                mReplyName = "";
                                mIndex = -1;
                                sendC.text = "";
                                focusNode.unfocus();
                              });
                            }

                          },
                        )
                      ],
                    ),

                  ],
                ),
              ),


            ],
          ),
        )
    );
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
