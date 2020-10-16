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
  String avatar;
  int createtime;
  String description;
  String did;
  int gender;
  String id;
  int lat;
  int like;
  int lng;
  String loc;
  String nickname;
  List<String> resImg;
  String title;
  String uid;
  bool liked;
  List<Comments> comments;

  Data(
      {this.avatar,
        this.createtime,
        this.description,
        this.did,
        this.gender,
        this.id,
        this.lat,
        this.like,
        this.lng,
        this.loc,
        this.nickname,
        this.resImg,
        this.title,
        this.uid,
        this.comments,
        this.liked
      });

  Data.fromJson(Map<String, dynamic> json) {
    avatar = json['Avatar'];
    createtime = json['Createtime'];
    description = json['Description'];
    did = json['Did'];
    gender = json['Gender'];
    id = json['Id'];
    lat = json['Lat'];
    like = json['Like'];
    lng = json['Lng'];
    loc = json['Loc'];
    nickname = json['Nickname'];
    resImg = json['ResImg'];
    title = json['Title'];
    uid = json['Uid'];
    liked = json['liked'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avatar'] = this.avatar;
    data['Createtime'] = this.createtime;
    data['Description'] = this.description;
    data['Did'] = this.did;
    data['Gender'] = this.gender;
    data['Id'] = this.id;
    data['Lat'] = this.lat;
    data['Like'] = this.like;
    data['Lng'] = this.lng;
    data['Loc'] = this.loc;
    data['Nickname'] = this.nickname;
    data['ResImg'] = this.resImg;
    data['Title'] = this.title;
    data['Uid'] = this.uid;
    data['liked'] = this.liked;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String commentId;
  String content;
  String uid;
  String ateUid;
  String nickname;
  String ateNickname;
  int createTime;

  Comments(
      {this.commentId,
        this.content,
        this.uid,
        this.ateUid,
        this.nickname,
        this.ateNickname,
        this.createTime});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    content = json['content'];
    uid = json['uid'];
    ateUid = json['ateUid'];
    nickname = json['nickname'];
    ateNickname = json['ateNickname'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['content'] = this.content;
    data['uid'] = this.uid;
    data['ateUid'] = this.ateUid;
    data['nickname'] = this.nickname;
    data['ateNickname'] = this.ateNickname;
    data['createTime'] = this.createTime;
    return data;
  }
}
