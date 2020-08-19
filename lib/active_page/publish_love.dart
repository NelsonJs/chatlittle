import 'package:flutter/material.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:littelchat/common/widgets/SnackBackUtil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PublishLovePage extends StatefulWidget {
  @override
  SatePublishLove createState() => SatePublishLove();
}

class SatePublishLove extends State<PublishLovePage> {
  bool hideAddImg = false;
  bool hidePersonImg = true;
  List<Asset> images = [];
  int uid = 0;
  TextEditingController nameC = TextEditingController(),
      yearsOldC = TextEditingController(),genderC = TextEditingController(),
      shenGaoC = TextEditingController(),tiZhongC = TextEditingController(),
      habitC = TextEditingController(),xueLiC = TextEditingController(),
      jobc = TextEditingController(),curLocC = TextEditingController(),
      jiGuanC = TextEditingController(),loveWordC = TextEditingController();


  loadImage() async {
    try{
      images = await MultiImagePicker.pickImages(maxImages: 1);
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return;
    }
    setState(() {
      hideAddImg = true;
      hidePersonImg = false;
    });
  }

  var _scaffoldkey = GlobalKey<ScaffoldState>();//把Scaffold的key自己保存

  commit(Map<String,dynamic> params) async {
    var byteData = await images[0].getByteData();
    Net().publishLoveIntro(byteData.buffer.asUint8List(), uid.toString(),params).then((value) {
      if (value.code > 0) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('发布介绍'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16),
            child: GestureDetector(
              child: Center(
                child: Text('发布'),
              ),
              onTap: () {
                SpUtils().getInt(SpUtils.uid).then((value) {
                  if (value == null) {
                    _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('未登录'),duration: Duration(seconds: 1)));
                  } else {
                    uid = value;
                    var name = nameC.text.toString();
                    var gender = genderC.text.toString();
                    var yearsOld = yearsOldC.text.toString();
                    var shenGao = shenGaoC.text.toString();
                    var tiZhong = tiZhongC.text.toString();
                    var habit = habitC.text.toString();
                    var xueLi = xueLiC.text.toString();
                    var job = jobc.text.toString();
                    var curLoc = curLocC.text.toString();
                    var jiGuan = jiGuanC.text.toString();
                    var loveWord = loveWordC.text.toString();
                    if (images.length == 0){
                      _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('未选择照片'),duration: Duration(seconds: 1)));
                    } else if (name.isEmpty || gender.isEmpty || yearsOld.isEmpty || shenGao.isEmpty || tiZhong.isEmpty
                        || habit.isEmpty || xueLi.isEmpty || job.isEmpty || curLoc.isEmpty || jiGuan.isEmpty || loveWord.isEmpty) {
                      _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('资料未填写完整'),duration: Duration(seconds: 1)));
                    } else {
                      var params = Map<String,dynamic>();
                      params["uid"] = uid;
                      params["nickname"] = name;
                      params["yearsOld"] = yearsOld;
                      params["shenGao"] = shenGao;
                      params["tiZhong"] = tiZhong;
                      params["habit"] = habit;
                      params["xueLi"] = xueLi;
                      params["job"] = job;
                      params["curLoc"] = curLoc;
                      params["jiGuan"] = jiGuan;
                      params["loveWord"] = loveWord;
                      commit(params);
                    }
                }
                });

              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            children: <Widget>[
              Offstage(
                child: FlatButton.icon(onPressed: (){
                  loadImage();
                }, icon: Icon(Icons.add), label: Text('个人照片')),
                offstage: hideAddImg,
              ),
              Offstage(
                offstage: hidePersonImg,
                child: images.length == 0 ? Placeholder():AssetThumb(asset: images[0], width: 300, height: 200),
              ),
              Row(
                children: <Widget>[
                  Text('姓名：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        maxLength: 4,
                        controller: nameC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('年龄：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        controller: yearsOldC,
                      ))
                ],
              ),Row(
                children: <Widget>[
                  Text('性别：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        maxLength: 1,
                        controller: genderC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('当前所在地：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        controller: curLocC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('籍贯：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        controller: jiGuanC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('爱好：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        controller: habitC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('学历：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        controller: xueLiC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('职业：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        controller: jobc,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('身高：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: shenGaoC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('体重：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: tiZhongC,
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Text('恋爱宣言：',style: TextStyle(fontSize: 14,color: Colors.grey[850])),
                  Expanded(
                      child: TextField(
                        controller: loveWordC,
                      ))
                ],
              ),
            ],
          ),
        ),
      )
      );
  }

}
