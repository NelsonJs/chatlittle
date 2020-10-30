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
  List<CommentData> comments;

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
      comments = new List<CommentData>();
      json['comments'].forEach((v) {
        comments.add(new CommentData.fromJson(v));
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

class CommentData {
  Comment comment;
  List<Comment> comments;

  CommentData({this.comment, this.comments});

  CommentData.fromJson(Map<String, dynamic> json) {
    comment =
    json['Comment'] != null ? new Comment.fromJson(json['Comment']) : null;
    if (json['Comments'] != null) {
      comments = new List<Comment>();
      json['Comments'].forEach((v) {
        comments.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comment != null) {
      data['Comment'] = this.comment.toJson();
    }
    if (this.comments != null) {
      data['Comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  String commentId;
  String cid;
  String fid;
  String pid;
  String content;
  String uid;
  String nickname;
  String replyuid;
  String replyname;
  int likenum;
  int status;
  int createTime;

  Comment(
      {this.commentId,
        this.cid,
        this.fid,
        this.pid,
        this.content,
        this.uid,
        this.nickname,
        this.replyuid,
        this.replyname,
        this.likenum,
        this.status,
        this.createTime});

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    cid = json['cid'];
    fid = json['fid'];
    pid = json['pid'];
    content = json['content'];
    uid = json['uid'];
    nickname = json['nickname'];
    replyuid = json['replyuid'];
    replyname = json['replyname'];
    likenum = json['likenum'];
    status = json['status'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['cid'] = this.cid;
    data['fid'] = this.fid;
    data['pid'] = this.pid;
    data['content'] = this.content;
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['replyuid'] = this.replyuid;
    data['replyname'] = this.replyname;
    data['likenum'] = this.likenum;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    return data;
  }
}
