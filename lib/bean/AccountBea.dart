class AccountBean {
  int code;
  int uid;
  String username;
  String pwd;
  String msg;


  AccountBean({this.uid, this.username, this.pwd});

  AccountBean.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    code = json['code'];
    username = json['username'];
    pwd = json['pwd'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['pwd'] = this.pwd;
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}
