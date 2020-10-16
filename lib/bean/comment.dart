class Comment {
  int code;
  List<Data> data;

  Comment({this.code, this.data});

  Comment.fromJson(Map<String, dynamic> json) {
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
  String commentId;
  String content;
  String uid;
  String ateUid;
  String nickname;
  String ateNickname;
  int createTime;

  Data(
      {this.commentId,
        this.content,
        this.uid,
        this.ateUid,
        this.nickname,
        this.ateNickname,
        this.createTime});

  Data.fromJson(Map<String, dynamic> json) {
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
