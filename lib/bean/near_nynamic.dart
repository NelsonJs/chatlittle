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
  int id;
  int lat;
  int liked;
  int likenum;
  int lng;
  String location;
  String nickname;
  List<String> resimg;
  String title;
  String uid;
  List<Comments> comments;

  Data(
      {this.avatar,
        this.createtime,
        this.description,
        this.did,
        this.gender,
        this.id,
        this.lat,
        this.liked,
        this.likenum,
        this.lng,
        this.location,
        this.nickname,
        this.resimg,
        this.title,
        this.uid,
        this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    avatar = json['Avatar'];
    createtime = json['Createtime'];
    description = json['Description'];
    did = json['Did'];
    gender = json['Gender'];
    id = json['Id'];
    lat = json['Lat'];
    liked = json['Liked'];
    likenum = json['Likenum'];
    lng = json['Lng'];
    location = json['Location'];
    nickname = json['Nickname'];
    if (json['Resimg'] != null) {
      resimg = json['Resimg'].cast<String>();
    }
    title = json['Title'];
    uid = json['Uid'];
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
    data['Liked'] = this.liked;
    data['Likenum'] = this.likenum;
    data['Lng'] = this.lng;
    data['Location'] = this.location;
    data['Nickname'] = this.nickname;
    data['Resimg'] = this.resimg;
    data['Title'] = this.title;
    data['Uid'] = this.uid;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String commentId;
  String cid;
  String content;
  String uid;
  String nickname;
  int likenum;
  int status;
  List<Reply> reply;
  int createTime;

  Comments(
      {this.commentId,
        this.cid,
        this.content,
        this.uid,
        this.nickname,
        this.likenum,
        this.status,
        this.reply,
        this.createTime});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    cid = json['cid'];
    content = json['content'];
    uid = json['uid'];
    nickname = json['nickname'];
    likenum = json['likenum'];
    status = json['status'];
    if (json['reply'] != null) {
      reply = new List<Reply>();
      json['reply'].forEach((v) {
        reply.add(new Reply.fromJson(v));
      });
    }
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['cid'] = this.cid;
    data['content'] = this.content;
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['likenum'] = this.likenum;
    data['status'] = this.status;
    if (this.reply != null) {
      data['reply'] = this.reply.map((v) => v.toJson()).toList();
    }
    data['createTime'] = this.createTime;
    return data;
  }
}

class Reply {
  String id;
  String uid;
  String content;
  String likenum;
  String nickname;
  String replyuid;
  String replynickname;

  Reply(
      {this.id,
        this.uid,
        this.content,
        this.likenum,
        this.nickname,
        this.replyuid,
        this.replynickname});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    content = json['content'];
    likenum = json['likenum'];
    nickname = json['nickname'];
    replyuid = json['replyuid'];
    replynickname = json['replynickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['content'] = this.content;
    data['likenum'] = this.likenum;
    data['nickname'] = this.nickname;
    data['replyuid'] = this.replyuid;
    data['replynickname'] = this.replynickname;
    return data;
  }
}
