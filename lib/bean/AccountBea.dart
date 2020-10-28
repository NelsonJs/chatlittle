class AccountBean {
  int code;
  String msg;
  UserData data;

  AccountBean({this.code,this.msg,this.data});

  AccountBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserData {
  String uid;
  String nickname;
  String phone;
  String pwd;
  int gender;
  String avatar;
  int createTime;
  int loginTime;
  int logoutTime;
  int status;

  UserData(
      {this.uid,
        this.nickname,
        this.phone,
        this.pwd,
        this.gender,
        this.avatar,
        this.createTime,
        this.loginTime,
        this.logoutTime,
        this.status});

  UserData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    phone = json['phone'];
    pwd = json['pwd'];
    gender = json['gender'];
    avatar = json['avatar'];
    createTime = json['create_time'];
    loginTime = json['login_time'];
    logoutTime = json['logout_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['pwd'] = this.pwd;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['create_time'] = this.createTime;
    data['login_time'] = this.loginTime;
    data['logout_time'] = this.logoutTime;
    data['status'] = this.status;
    return data;
  }
}
