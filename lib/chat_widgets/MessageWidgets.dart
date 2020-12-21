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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Offstage(
                          child: Align(
                            child: CupertinoActivityIndicator(radius: 8),
                          ),
                          offstage: true,
                        ),
                        Container(
                          child: Container(child: Text(txt,style: TextStyle(color: Colors.white)),constraints: BoxConstraints(maxWidth: 200),),
                          margin: EdgeInsets.only(right: 10,left: 5),
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.rectangle,borderRadius: BorderRadius.all(Radius.circular(4))),
                        ),
                      ],
                    ),
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
