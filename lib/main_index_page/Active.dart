import 'package:flutter/material.dart';
import 'package:littelchat/active_page/PublishActive.dart';

class Active extends StatefulWidget {
  @override
  ActivePage createState() => ActivePage();

}

class ActivePage extends State<Active> with SingleTickerProviderStateMixin {

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
    return Scaffold(
      body: ListView.builder(
          itemCount: 12,
          itemBuilder: (context,index){
        return Card(
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('周五举办一场友谊篮球赛'),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Image.asset(
                        'images/q1.jpg'
                    ),
                  )
                ],
              )
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishActive()));
      },child: Icon(Icons.add),),
    );
  }




}