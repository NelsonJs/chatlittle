import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/chat/PersonDetail.dart';

class ItemOtherText extends StatelessWidget {
  String txt;
  String name;

  ItemOtherText({this.txt,this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0,10,0,10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/p1.jpg'),
              radius: 20,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(name, style: TextStyle(fontSize: 12)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 45, 0),
                    child: Text(txt)
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class ItemSelfText extends StatelessWidget {
  String txt;

  ItemSelfText(this.txt);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0,10,0,10),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: Padding(
                      padding: EdgeInsets.fromLTRB(45, 10, 10, 0),
                      child: Align(alignment: Alignment.topRight,child: Text(txt),),
                    )),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/p1.jpg'),
                      radius: 20,
                    ),
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonDetail()));
                    },
                )
              ],
              )
            ),
          ],
        ));
  }
}
