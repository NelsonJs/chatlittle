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
    SpUtils().getString(SpUtils.userName).then((value) {
      userName = value;
      SpUtils().getString(SpUtils.phone).then((value) {
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

  showAdDialog(BuildContext context, String desc, int type) {
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
                  decoration: InputDecoration(hintText: '输入新内容'),
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
                setState(() {
                  hideLoading = false;
                });
                SpUtils().getInt(SpUtils.uid).then((value) {
                  if (value != null) {
                    var tempName,tempPhone,tempGender;
                    if (type == 1) {
                      tempName = editingController.text.toString();
                    } else if (type == 2) {
                      tempPhone = editingController.text.toString();
                    } else if (type == 3) {
                      tempGender = editingController.text.toString();
                    }
                    Net()
                        .updateUserInfo(value.toString(), tempName, tempPhone, tempGender)
                        .then((value) {
                      if (value.code == -1) {
                        print(value.msg);
                        if (type == 1) {
                          userName = null;
                        } else if (type == 2) {
                          phone = null;
                        } else if (type == 3) {
                          gender = null;
                        }
                      } else {
                        if (type == 1) {
                          userName = tempName;
                          SpUtils().saveString(SpUtils.userName, userName);
                        } else if (type == 2) {
                          phone = tempPhone;
                          SpUtils().saveString(SpUtils.phone, phone);
                        } else if (type == 3) {
                          gender = tempGender;
                        }
                        setState(() {
                          hideLoading = true;
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
      body: ConstrainedBox(constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('昵称')),
                          Text(userName == null ? "暂无" : userName,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[350])),
                          Icon(Icons.navigate_next, color: Colors.grey[350])
                        ],
                      ),
                      onTap: () {
                        showAdDialog(context, '请输入新昵称', 1);
                      },
                    )),
                Divider(height: 1, color: Colors.grey[400]),
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('手机号')),
                          Text(phone == null ? "暂无" : phone,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[350])),
                          Icon(Icons.navigate_next, color: Colors.grey[350])
                        ],
                      ),
                      onTap: () {
                        showAdDialog(context, '请输入手机号', 2);
                      },
                    )),
                Divider(height: 1, color: Colors.grey[400]),
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('性别')),
                          Text(gender == null ? "暂无" : gender,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[350])),
                          Icon(Icons.navigate_next, color: Colors.grey[350])
                        ],
                      ),
                      onTap: () {
                        showAdDialog(context, '请输入性别', 3);
                      },
                    )),
                Divider(height: 1, color: Colors.grey[400])
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Offstage(
                child: CupertinoActivityIndicator(radius: 15),
                offstage: hideLoading,
              ))
        ],
      )),
    );
  }
}
