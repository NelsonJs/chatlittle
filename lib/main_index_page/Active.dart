import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:littelchat/active_page/PublishActive.dart';
import 'package:littelchat/bean/active_bean.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/widgets/ImageWidget.dart';

class Active extends StatefulWidget {
  @override
  ActivePage createState() => ActivePage();

}

class ActivePage extends State<Active> with SingleTickerProviderStateMixin {
  List<Data> mData = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child:Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(child: Image.network("https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3792581192,4167354173&fm=26&gp=0.jpg",
                        loadingBuilder: (c,w,e){
                          if (e == null) {
                            return w;
                          } else {
                            return CupertinoActivityIndicator(radius:15);
                          }
                        },fit: BoxFit.cover)),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('晚上打球！',style: TextStyle(fontSize: 12,color: Colors.black87)),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
            ),
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(
                    2, index == 0 ? 2.5 : 3),
            crossAxisSpacing: 4,
        )
      );
  }




}