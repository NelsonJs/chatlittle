import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recomment extends StatefulWidget {
  @override
  RecommentPage createState() => RecommentPage();
}

class RecommentPage extends State<Recomment> with AutomaticKeepAliveClientMixin {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 12,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: null,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 15, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('images/p1.jpg'),
                          radius: 33,
                        ),
                        /*Positioned(
                          right: 0,
                          bottom: 2,
                          child: Container(
                            child: Text('24',style: TextStyle(color: Colors.yellow,fontSize: 12)),
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              shape: BoxShape.rectangle
                            ),
                          ),
                        )*/
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 0),child: Text('王大锤',style: TextStyle(fontSize: 15),)),
                            Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 0),child: Container(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                  child:Text('24',style: TextStyle(color: Colors.white,fontSize: 12))),
                              decoration: BoxDecoration(
                                  color: Colors.red[300],
                                  shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                            )),
                            Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 0),child: Text('签名：今天天气不错哇',style: TextStyle(color: Colors.grey,fontSize: 12))),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('0.33km',style: TextStyle(color: Colors.grey,fontSize: 12),),
                        Text('.',style: TextStyle(color: Colors.grey,fontSize: 12)),
                        Text('在线',style: TextStyle(color: Colors.grey,fontSize: 12))
                      ],
                    )
                  ],
                ),
              ),
            );
          }
      )
    );
  }

  _onPress() {
    setState(() {
      count++;
      updateKeepAlive();
    });
  }

  @override
  bool get wantKeepAlive => true;

}