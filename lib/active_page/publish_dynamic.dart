import 'dart:io';

import 'package:flutter/material.dart';

class PublishDynamic extends StatefulWidget {
  @override
  DynamicState createState() => DynamicState();
}

class DynamicState extends State<PublishDynamic> {
  int crossCount = 1,itemCount = 1;
  List<String> imgs = [];

  @override
  void initState() {
    imgs.add("images/addimg.png");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: FlatButton(
                onPressed: null,
                child: Text('发表')),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    hintText: "这一刻的想法...",
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 10)
                ),
              ),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 0.69
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context,index){
                    String path;
                    if (index == imgs.length-1){
                        path = imgs[index];
                    }
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        child:path == "images/addimg.png" ? Image(image: AssetImage(path)):Image.file(File(path)),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

}