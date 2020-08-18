class NearDynamic {
  int code;
  List<Data> data;

  NearDynamic({this.code, this.data});

  NearDynamic.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int uid;
  String title;
  String desc;
  String img;
  int gender;
  String begin;
  String location;
  int lng;
  int lat;
  int peoplenum;
  int peopletotalnum;
  int like;
  int commentnum;
  int commentid;
  int time;
  List<String> resImg;
  String nickname;
  String phone;
  String pwd;
  String avatar;
  int createTime;
  int loginTime;
  int logoutTime;
  int status;
  int yearOld;
  bool liked;

  Data(
      {this.id,
        this.uid,
        this.title,
        this.desc,
        this.img,
        this.gender,
        this.begin,
        this.location,
        this.lng,
        this.lat,
        this.peoplenum,
        this.peopletotalnum,
        this.like,
        this.commentnum,
        this.commentid,
        this.time,
        this.resImg,
        this.nickname,
        this.phone,
        this.pwd,
        this.avatar,
        this.createTime,
        this.loginTime,
        this.logoutTime,
        this.status,
        this.yearOld,
        this.liked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    title = json['title'];
    desc = json['desc'];
    img = json['img'];
    gender = json['gender'];
    begin = json['begin'];
    location = json['location'];
    lng = json['lng'];
    lat = json['lat'];
    peoplenum = json['peoplenum'];
    peopletotalnum = json['peopletotalnum'];
    like = json['like'];
    commentnum = json['commentnum'];
    commentid = json['commentid'];
    time = json['time'];
    resImg = json['res_img'].cast<String>();
    nickname = json['nickname'];
    phone = json['phone'];
    pwd = json['pwd'];
    avatar = json['avatar'];
    createTime = json['createTime'];
    loginTime = json['loginTime'];
    logoutTime = json['logout_time'];
    status = json['status'];
    yearOld = json['year_old'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['img'] = this.img;
    data['gender'] = this.gender;
    data['begin'] = this.begin;
    data['location'] = this.location;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['peoplenum'] = this.peoplenum;
    data['peopletotalnum'] = this.peopletotalnum;
    data['like'] = this.like;
    data['commentnum'] = this.commentnum;
    data['commentid'] = this.commentid;
    data['time'] = this.time;
    data['res_img'] = this.resImg;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['pwd'] = this.pwd;
    data['avatar'] = this.avatar;
    data['createTime'] = this.createTime;
    data['loginTime'] = this.loginTime;
    data['logout_time'] = this.logoutTime;
    data['status'] = this.status;
    data['year_old'] = this.yearOld;
    data['liked'] = this.liked;
    return data;
  }
}
