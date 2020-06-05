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
  String content;
  int sendId;
  int receiveId;

  Data({this.content, this.sendId, this.receiveId});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['Content'];
    sendId = json['SendId'];
    receiveId = json['ReceiveId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Content'] = this.content;
    data['SendId'] = this.sendId;
    data['ReceiveId'] = this.receiveId;
    return data;
  }
}

