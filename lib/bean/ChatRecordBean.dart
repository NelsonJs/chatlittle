class ChatRecordBean {
  int code;
  List<Data> data;

  ChatRecordBean({this.code, this.data});

  ChatRecordBean.fromJson(Map<String, dynamic> json) {
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
  String msgId;
  String uid;
  String peerid;
  String ctype;
  String content;
  int msgType;
  String pic;
  int status;
  int createTime;

  Data(
      {this.msgId,
        this.uid,
        this.peerid,
        this.ctype,
        this.content,
        this.msgType,
        this.pic,
        this.status,
        this.createTime});

  Data.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    uid = json['uid'];
    peerid = json['peerid'];
    ctype = json['ctype'];
    content = json['content'];
    msgType = json['msg_type'];
    pic = json['Pic'];
    status = json['Status'];
    createTime = json['Create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_id'] = this.msgId;
    data['uid'] = this.uid;
    data['peerid'] = this.peerid;
    data['ctype'] = this.ctype;
    data['content'] = this.content;
    data['msg_type'] = this.msgType;
    data['Pic'] = this.pic;
    data['Status'] = this.status;
    data['Create_time'] = this.createTime;
    return data;
  }
}


