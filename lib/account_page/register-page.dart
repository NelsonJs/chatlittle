import 'package:flutter/material.dart';
import 'package:littelchat/common/util/Net.dart';

class RegisterPage extends StatefulWidget {
  @override
  _StateRegister createState() => _StateRegister();
}

class _StateRegister extends State<RegisterPage> {
  TextEditingController _phoneC = TextEditingController();
  TextEditingController _pwdC = TextEditingController();

  _showSnackBar(BuildContext context,String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
        elevation: 0.5,
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 100),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              TextField(
                controller: _phoneC,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone_android, size: 25,color: Colors.grey),
                  hintText: '手机号',
                  hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _pwdC,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, size: 25,color: Colors.grey),
                  hintText: '密码',
                  hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top:20),
                          child: Builder(
                              builder: (BuildContext c){
                                return FlatButton(
                                    onPressed: (){
                                      var login = Net().register(
                                          _phoneC.text, _pwdC.text);
                                      login.then((value) {
                                        if (value == null) return;
                                        if (value.code == -1) {
                                          _showSnackBar(c,value.msg);
                                        } else if (value.data.uid != null) {
                                          Navigator.pop(c,value.data.uid);
                                        }
                                      });
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
                                    color:  Colors.blue,
                                    textColor: Colors.white,
                                    disabledColor:  Colors.blueAccent[100],
                                    focusColor: Colors.blueAccent,
                                    child: Text('注册',style: TextStyle(color: Colors.white))
                                );
                              }
                          )
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}