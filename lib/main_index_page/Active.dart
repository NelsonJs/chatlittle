import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/active_page/PublishActive.dart';
import 'package:littelchat/bean/active_bean.dart';
import 'package:littelchat/common/util/Net.dart';

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
    return Scaffold(
      body:FutureBuilder<ActiveBean>(
          future: Net().activeList(),
          builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError){
            return Text('data');
          } else {
            if (snapshot.data.data != null) {
              mData.clear();
              mData.addAll(snapshot.data.data);
            }
            return  ListView.builder(
                itemCount: mData.length,
                itemBuilder: (context,index){
                  return Card(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(mData[index].title),
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
                });
          }
        } else {
          return CupertinoActivityIndicator();
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PublishActive()));
      },child: Icon(Icons.add),),
    );
  }




}