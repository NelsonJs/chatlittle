class ResourceBean {
  int code;
  List<String> data;
  String msg;

  ResourceBean({this.code, this.data,this.msg});

  ResourceBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = json['data'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}