import 'package:flutter/material.dart';
import 'package:littelchat/bean/near_nynamic.dart';

class DynamicDetail extends StatefulWidget {

  DynamicDetail(this.did,{this.comments});

  final String did;
  final List<Comments> comments;

  @override
  _DynamicDetailState createState() => _DynamicDetailState();


}

class _DynamicDetailState extends State<DynamicDetail> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('详情',style: TextStyle(color: Colors.black87,fontSize: 16)),
        elevation: 0.5
      ),
      body: Column(
        children: [
         Expanded(
             flex: 1,
             child:  ListView.builder(
                 itemCount: widget.comments == null ? 0 : widget.comments.length,
                 itemBuilder: (context,index){
                   return Padding(
                     padding: EdgeInsets.only(top: 5,bottom: 5),
                     child: Row(
                       children: [
                         Text(widget.comments[index].nickname),
                         Offstage(
                           offstage: (widget.comments[index].ateUid == null || widget.comments[index].ateUid == "") ? true:false ,
                           child: Text('@'+widget.comments[index].ateNickname),
                         ),
                         Text("："+widget.comments[index].content),
                       ],
                     ),
                   );
                 }
             )
         ),
          Container(
            margin: EdgeInsets.only(bottom: 5,top: 5),
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '评论',
                        contentPadding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,width: 1),borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                    ),flex: 1,
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
            ),
          )
        ],
      ),
    );
  }

}