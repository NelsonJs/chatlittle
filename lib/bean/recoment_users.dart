class RecomentBean {
  List<Data> data;

  RecomentBean({this.data});

  RecomentBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String uid;
  String nickname;
  String phone;
  String gender;
  String pwd;
  String avatar;
  int createTime;
  int loginTime;
  int logoutTime;
  int status;
  int yearOld;

  Data(
      {this.uid,
        this.nickname,
        this.phone,
        this.gender,
        this.pwd,
        this.avatar,
        this.createTime,
        this.loginTime,
        this.logoutTime,
        this.status,
        this.yearOld});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    phone = json['phone'];
    gender = json['gender'];
    pwd = json['pwd'];
    avatar = json['avatar'];
    createTime = json['createTime'];
    loginTime = json['loginTime'];
    logoutTime = json['logout_time'];
    status = json['status'];
    yearOld = json['year_old'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['pwd'] = this.pwd;
    data['avatar'] = this.avatar;
    data['createTime'] = this.createTime;
    data['loginTime'] = this.loginTime;
    data['logout_time'] = this.logoutTime;
    data['status'] = this.status;
    data['year_old'] = this.yearOld;
    return data;
  }
}
