class UpdateBean {
  int code;
  String msg;
  Data data;

  UpdateBean({this.code,this.msg, this.data});

  UpdateBean.fromJson(Map<String, dynamic> json) {
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
  String url;
  int num;
  String description;
  String channel;
  int createtime;

  Data({this.url, this.num, this.description, this.channel, this.createtime});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    num = json['num'];
    description = json['description'];
    channel = json['channel'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['num'] = this.num;
    data['description'] = this.description;
    data['channel'] = this.channel;
    data['createtime'] = this.createtime;
    return data;
  }
}
