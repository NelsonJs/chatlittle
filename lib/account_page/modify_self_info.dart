import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/SpUtils.dart';

class ModifyInfoPage extends StatefulWidget {
  @override
  SateModifyInfo createState() => SateModifyInfo();
}




class SateModifyInfo extends State<ModifyInfoPage> {
  String userName;
  String phone;
  String gender;
  bool hideLoading = true;

  initData() {
    SpUtils().getString(SpUtils.userName).then((value){
        userName = value;
        SpUtils().getString(SpUtils.phone).then((value){
          phone = value;
          setState(() {});
        });
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  showAdDialog(BuildContext context,String desc,int type) {
    TextEditingController editingController = TextEditingController();
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(desc),
                TextField(
                  decoration: InputDecoration(
                    hintText: '输入新内容'
                  ),
                  controller: editingController,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                SpUtils().getInt(SpUtils.uid).then((value){
                  if (value != null) {
                    String field = "";
                    if (type == 1){
                      field = "nick_name";
                    } else if (type == 2) {
                      field = "phone";
                    } else if (type == 3) {
                      field = "gender";
                    }
                    Net().updateUserInfo(value.toString(), field, field,field).then((value){
                      if (value.code == -1){
                          print(value.msg);
                      } else {
                        setState(() {
                          hideLoading = false;
                          if (type == 1){
                            userName = editingController.text.toString();
                          } else if (type == 2) {
                            phone = editingController.text.toString();
                          } else if (type == 3) {
                            gender = editingController.text.toString();
                          }
                        });
                      }
                    });
                  }

                });

                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('修改个人信息')),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: GestureDetector(child: Row(
                      children: <Widget>[
                        Expanded(child: Text('昵称')),
                        Text(userName == null ? "暂无" : userName,style: TextStyle(fontSize: 12,color: Colors.grey[350])),
                        Icon(Icons.navigate_next,color: Colors.grey[350])
                      ],
                    ),onTap: () {
                      showAdDialog(context,'请输入新昵称',1);
                    },
                    )),
                Divider(height: 1,color: Colors.grey[400]),
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('手机号')),
                          Text(phone == null ? "暂无" : phone,style: TextStyle(fontSize: 12,color: Colors.grey[350])),
                          Icon(Icons.navigate_next,color: Colors.grey[350])
                        ],
                      ),
                      onTap: (){
                        showAdDialog(context,'请输入手机号',2);
                      },
                    )),
                Divider(height: 1,color: Colors.grey[400]),
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('性别')),
                          Text(gender == null ? "暂无" : gender,style: TextStyle(fontSize: 12,color: Colors.grey[350])),
                          Icon(Icons.navigate_next,color: Colors.grey[350])
                        ],
                      ),
                      onTap: (){
                        showAdDialog(context,'请输入性别',3);
                      },
                    )),
                Divider(height: 1,color: Colors.grey[400])
              ],
            ),

          ),
          Offstage(
            child: Positioned(child: CupertinoActivityIndicator(radius: 15)),
            offstage: hideLoading,
          )
        ],
      ),
    );
  }

}