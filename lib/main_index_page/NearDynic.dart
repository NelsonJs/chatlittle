import 'package:flutter/material.dart';

class NearDynic extends StatefulWidget {
  @override
  NearDynicPage createState() => NearDynicPage();
}

class NearDynicPage extends State<NearDynic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 12,
          itemBuilder: (context,index) {
          Widget w;
          if (index %2== 0){
            w = oneImg();
          } else {
            w = empty();
          }
            return Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('images/p1.jpg'),
                        radius: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: Text('三胖',style: TextStyle(fontSize: 15,color: Colors.red))),
                          Padding(padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    child: Text('24',style: TextStyle(color: Colors.white,fontSize: 12)),
                                    decoration: BoxDecoration(
                                      color: Colors.red[300],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                  )
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                  Text('今天天气明朗，万物可爱'),
                  Container(
                      child: w,
                  ),
                  Row(
                    children: <Widget>[
                      Text('18小时前·4.15km·软件园二期·546播放')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton.icon(onPressed: null, icon: Icon(Icons.message), label: Text('55')),
                      FlatButton.icon(onPressed: null, icon: Image.asset('images/3.0x/like.png'), label: Text('485'))
                    ],
                  ),
                  Divider(height: 1,color: Colors.grey[300],)
                ],
              ),
            );
          }
      ),
    );
  }

  Widget oneImg(){
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Image.asset(
          'images/q1.jpg'
      ),
    );
  }

  Widget empty() {
    return Container();
  }

}