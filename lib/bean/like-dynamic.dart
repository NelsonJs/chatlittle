class LikeDynamic {
  int code;
  String msg;
  Data data;

  LikeDynamic({this.code, this.msg, this.data});

  LikeDynamic.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String did;
  String uid;
  String nickname;
  String title;
  String avatar;
  int gender;
  int likeNum;
  bool liked;
  String location;
  int lat;
  int lng;
  int createTime;
  List<String> resImg;
  String desc;

  Data(
      {this.did,
        this.uid,
        this.nickname,
        this.title,
        this.avatar,
        this.gender,
        this.likeNum,
        this.liked,
        this.location,
        this.lat,
        this.lng,
        this.createTime,
        this.resImg,
        this.desc});

  Data.fromJson(Map<String, dynamic> json) {
    did = json['did'];
    uid = json['uid'];
    nickname = json['nickname'];
    title = json['title'];
    avatar = json['avatar'];
    gender = json['gender'];
    likeNum = json['likeNum'];
    liked = json['liked'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    createTime = json['createTime'];
    resImg = json['resImg'].cast<String>();
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['did'] = this.did;
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['title'] = this.title;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['likeNum'] = this.likeNum;
    data['liked'] = this.liked;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['createTime'] = this.createTime;
    data['resImg'] = this.resImg;
    data['desc'] = this.desc;
    return data;
  }
}
