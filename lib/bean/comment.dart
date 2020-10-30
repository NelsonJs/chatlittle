class CommentBean {
  int code;
  List<Data> data;

  CommentBean({this.code, this.data});

  CommentBean.fromJson(Map<String, dynamic> json) {
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
  Comment comment;
  List<Comment> comments;

  Data({this.comment, this.comments});

  Data.fromJson(Map<String, dynamic> json) {
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
