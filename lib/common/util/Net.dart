import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:littelchat/bean/AccountBea.dart';
import 'package:littelchat/bean/ChatRecordBean.dart';
import 'package:littelchat/bean/ConversationBean.dart';
import 'package:littelchat/bean/active_bean.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/bean/resource_bean.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/util/SpUtils.dart';

class Net {
    Net([this.context]){
        _options = Options(extra: {"context":context});
    }

    BuildContext context;
    Options _options;

    static Dio dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.1.6:8080/',
        connectTimeout: 5000
    ));

    static void init() {

      //设置header



    }

    Future<AccountBean> register(String name,String pwd) async {
        var map = Map<String,dynamic>();
        map["username"] = name;
        map["pwd"] = pwd;
        var r = await dio.post("user/register",data: map);
        Global.accountBean = AccountBean.fromJson(r.data);
        if (Global.accountBean.code != -1) {
            SpUtils().saveInt(SpUtils.uid, Global.accountBean.uid);
            SpUtils().saveString(SpUtils.userName, Global.accountBean.username);
        }
        print("${Global.accountBean}");
        return Global.accountBean;
    }

    Future<AccountBean> login(String name,String pwd) async {
        var map = Map<String,dynamic>();
        map["username"] = name;
        map["pwd"] = pwd;
        var r = await dio.post("user/login",data: map);
        Global.accountBean = AccountBean.fromJson(r.data);
        if (Global.accountBean.code != -1) {
            SpUtils().saveInt(SpUtils.uid, Global.accountBean.uid);
            SpUtils().saveString(SpUtils.userName, Global.accountBean.username);
        }
        print("${Global.accountBean}");
        return Global.accountBean;
    }

    Future<ConversationBean> conversations(String uid) async {
        var map = Map<String,dynamic>();
        map["uid"] = uid;
        Response r = await dio.get("user/conversations",queryParameters: map);
        ConversationBean conversationBean = ConversationBean.fromJson(r.data);
        return conversationBean;
    }

    Future<ChatRecordBean> recordList(String uid,String otherId) async {
        var map = Map<String,dynamic>();
        map["selfId"] = uid;
        map["otherId"] = otherId;
        Response r = await dio.get("user/record",queryParameters: map);
        ChatRecordBean bean = ChatRecordBean.fromJson(r.data);
        return bean;
    }

    Future<NearDynamic> nearDynamicList() async {
        Response r = await dio.get("index/neardynamic");
        print(r.data.toString());
        return NearDynamic.fromJson(r.data);
    }

    Future<ActiveBean> activeList() async {
        Response r = await dio.get("index/neardynamic");
        return ActiveBean.fromJson(r.data);
    }



    void uploadImg(List<String> paths) async {
        if (paths == null || paths.length == 0){

        }
        List<MultipartFile> data = [];
        for (var i = 0; i < paths.length; i++) {
            data.add(await MultipartFile.fromFile(paths[i]));
        }
        var formData = FormData.fromMap({
            "name":"upload",
            "files":data
        });
        await dio.post("path",data: formData);
    }

    Future<ResourceBean> uploadImgWithByte(List<List<int>> bytes) async {
        print("图片个数:${bytes.length}");
        var formData = FormData();
       for (var i=0; i<bytes.length;i++) {
           formData.files.add(MapEntry("upload", MultipartFile.fromBytes(bytes[i],filename: "$i.jpg")));
       }
        var res = await dio.post("resource/uploadimg",data: formData);
        print(res.data.toString());
        return ResourceBean.fromJson(res.data);
    }

    Future<ResourceBean> publishDynamic(List<int> ids,String title) async {
        var map = Map<String,dynamic>();
        SpUtils().getInt(SpUtils.uid).then((value) {
           map["uid"] = value.toString();
           map["title"] = title;
           map["ids"] = ids;
        });
        var res = await dio.post("index/dynamic",data: map);
        print("提交数据->${res.data.toString()}");
        return ResourceBean.fromJson(res.data);
    }



}