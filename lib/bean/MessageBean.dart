class MessageBean {
  int Code;
  String sendId;
  String receiveId;
  int msgType;
  String content;

  MessageBean({this.Code,this.sendId, this.receiveId, this.msgType, this.content});

  MessageBean.fromJson(Map<String, dynamic> json) {
    sendId = json['SendId'];
    receiveId = json['ReceiveId'];
    msgType = json['MsgType'];
    content = json['Content'];
    Code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SendId'] = this.sendId;
    data['ReceiveId'] = this.receiveId;
    data['MsgType'] = this.msgType;
    data['Content'] = this.content;
    data['Code'] = this.Code;
    return data;
  }
}
