import 'package:littelchat/bean/near_nynamic.dart';

class LikeComment {
  int code;
  String msg;
  Comment data;

  LikeComment({this.code, this.msg, this.data});

  LikeComment.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Comment.fromJson(json['data']) : null;
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

