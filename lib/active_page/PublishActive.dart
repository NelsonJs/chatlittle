
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:littelchat/common/widgets/loading.dart';

class PublishActive extends StatefulWidget{
  @override
  _PublishStateActive createState() => _PublishStateActive();
}

class _PublishStateActive extends State<PublishActive> {
  bool btnVisible = false;
  bool imgVisible = true;
  String txt = "点击上传封面";
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickFile.path);
      txt = "点击更换封面";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        Center(child: Padding(padding: EdgeInsets.only(right: 10),child: GestureDetector(child: Text('发布'),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Loading()));
          //showDialog(context: context,child: Loading());
        },)))
      ],),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: "标题",
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 10)
                    ),
                  ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "描述",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 10)
                  ),
                ),
                Offstage(
                  offstage: btnVisible,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: RaisedButton.icon(onPressed: (){
                      getImage();
                    }, icon: Icon(Icons.add), label: Text(txt)),
                  )
                ),
                Offstage(
                  offstage: _image == null ? true : false,
                  child:  _image == null ? Placeholder():Image.file(_image,fit: BoxFit.contain,height: 300,width: 300),
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('集合地点：北站')),
                    GestureDetector(
                      child: Text('集合时间：${DateTime.now()}'),
                      onTap: (){
                        var datePicker = showDatePicker(context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2020), lastDate: DateTime(2050));
                        datePicker.then((value){

                        });
                      },
                    )
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }

}