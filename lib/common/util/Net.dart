import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:littelchat/bean/AccountBea.dart';
import 'package:littelchat/bean/ChatRecordBean.dart';
import 'package:littelchat/bean/ConversationBean.dart';
import 'package:littelchat/bean/active_bean.dart';
import 'package:littelchat/bean/comment.dart';
import 'package:littelchat/bean/conversation-list.dart';
import 'package:littelchat/bean/love_intro.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/bean/recoment_users.dart';
import 'package:littelchat/bean/resource_bean.dart';
import 'package:littelchat/bean/respont_parent.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/util/SpUtils.dart';

class Net {
    Net([this.context]){
        _options = Options(extra: {"context":context});
    }

    BuildContext context;
    Options _options;

    static Dio dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.1.7:8080/',
        connectTimeout: 5000,
        responseType: ResponseType.json
    ));

    static void init() {

      //设置header



    }

    Future<AccountBean> register(String name,String pwd) async {
        print("名称：$name 密码：$pwd");
        var map = Map<String,dynamic>();
        map["phone"] = name;
        map["pwd"] = pwd;
        var r = await dio.post("user/register",data: map);
        Global.accountBean = AccountBean.fromJson(r.data);
        if (Global.accountBean.code == 1) {
            SpUtils().saveString(SpUtils.uid, Global.accountBean.data.uid);
            SpUtils().saveString(SpUtils.userName, Global.accountBean.data.nickname);
            SpUtils().saveString(SpUtils.phone, Global.accountBean.data.phone);
            SpUtils().saveInt(SpUtils.gender, Global.accountBean.data.gender);
        }
        print("${Global.accountBean}");
        return Global.accountBean;
    }

    Future<AccountBean> login(String name,String pwd) async {
        print("名称：$name 密码：$pwd");
        var map = Map<String,dynamic>();
        map["phone"] = name;
        map["pwd"] = pwd;
        var r = await dio.post("user/login",data: map);
        Global.accountBean = AccountBean.fromJson(r.data);
        if (Global.accountBean.code == 1) {
            SpUtils().saveString(SpUtils.uid, Global.accountBean.data.uid);
            SpUtils().saveString(SpUtils.userName, Global.accountBean.data.nickname);
            SpUtils().saveString(SpUtils.phone, Global.accountBean.data.phone);
            SpUtils().saveInt(SpUtils.gender, Global.accountBean.data.gender);
        }
        print("${Global.accountBean.code}");
        return Global.accountBean;
    }

    Future<ConversationBean> conversations(String uid) async {
        var map = Map<String,dynamic>();
        map["uid"] = uid;
        Response r = await dio.get("user/conversations",queryParameters: map);
        ConversationBean conversationBean = ConversationBean.fromJson(r.data);
        return conversationBean;
    }

    Future<ChatRecordBean> recordList(String uid,String otherId,String ctype) async {
        var map = Map<String,dynamic>();
        map["uid"] = uid;
        map["peerId"] = otherId;
        map["ctype"] = ctype;
        Response r = await dio.get("conversation/record",queryParameters: map);
        ChatRecordBean bean = ChatRecordBean.fromJson(r.data);
        return bean;
    }

    Future<NearDynamic> nearDynamicList() async {
        Response r = await dio.get("index/neardynamic");
        print("nearDynamicList-->"+r.data.toString());
        return NearDynamic.fromJson(r.data);
    }

    Future<Comment> getComments() async {
        Response r = await dio.get("comment/list");
        print("getComments--->"+r.data.toString());
        return Comment.fromJson(r.data);
    }

    Future<ResponseParent> sendComment(String did,content,uid,nickname,ateUid,ateNickname) async{
        var m = Map<String,dynamic>();
        m["did"] = did;
        m["content"] = content;
        m["uid"] = uid;
        m["ateUid"] = ateUid;
        m["nickname"] = nickname;
        m["ateNickname"] = ateNickname;
        Response res = await dio.post("/comment/create",data: m);
        return ResponseParent.fromJson(res.data);
    }


    Future<LoveIntro> loveIntroList(int time) async {
        Response r = await dio.get("index/loveintrolist?t=time&limit=4");
        print("-------------->"+r.data.toString());
        var l = LoveIntro.fromJson(r.data);
        return l;
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



    Future<ResourceBean> publishLoveIntro(List<int> bytes,String uid,Map<String,dynamic> paramMap) async {
        var formData = FormData();
        formData.files.add(MapEntry("upload", MultipartFile.fromBytes(bytes,filename: "0.jpg")));
        var params = Map<String,dynamic>();
       /* params["uid"] = uid;
        dio.options.responseType =  ResponseType.plain;
        var res = await dio.post("resource/uploadimg",data: formData,queryParameters: params);
        print(res.data.toString());
        Map<String,dynamic> map = json.decode(res.data.toString());
        if (map["data"] != null) {
            List<dynamic> list = map["data"];
            if (list.length > 0) {
                dio.options.responseType =  ResponseType.json;
                res = await dio.post("index/loveintro",data: formData,queryParameters: paramMap);
            }
        }*/
        List<MapEntry<String,String>> list = [];
        paramMap.forEach((key, value) {
            list.add(MapEntry(key, '$value'));
        });
        formData.fields.addAll(list);
        var res = await dio.post("index/loveintro",data: formData);
        print(res.data.toString());
        return ResourceBean.fromJson(res.data);
    }

    Future<ResourceBean> publishDynamic(List<String> ids,String title,String desc) async {
        var map = Map<String,dynamic>();
        print("图片：$ids");
        map["uid"] = "100";
        map["title"] = title;
        map["desc"] = desc;
        map["resImg"] = ids;
       /* SpUtils().getInt(SpUtils.uid).then((value) {
           map["uid"] = value.toString();
           map["title"] = title;
           map["desc"] = desc;
           //map["ids"] = ids;
        });*/
        var res = await dio.post("index/dynamic",data: map);
        print("提交数据->${res.data.toString()}");
        return ResourceBean.fromJson(res.data);
    }

    Future<ResourceBean> avatar(List<int> avatar,String uid) async {
        var formData = FormData();
        formData.files.add(MapEntry("upload", MultipartFile.fromBytes(avatar,filename: "0.jpg")));
        var res = await dio.post("user/avatar?uid=$uid",data: formData);
        print(res.data.toString());
        return ResourceBean.fromJson(res.data);
    }

    Future<ResourceBean> dynamicImage(List<List<int>> imgs) async {
        var formData = FormData();
        for (int i = 0; i < imgs.length; i++) {
            int micro = DateTime.now().microsecond;
            formData.files.add(MapEntry("uploads", MultipartFile.fromBytes(imgs[i],filename: micro.toString()+".jpg")));
        }
        var res = await dio.post("resource/image/dynamic/",data: formData);
        ResourceBean rb = ResourceBean.fromJson(res.data);
        print(rb.data);
        return rb;
    }

    Future<ResponseParent> updateUserInfo(String uid,String nickName,String phone,String gender) async {
        var map = Map<String,dynamic>();
        print("uid----->$uid");
        if (uid == null){
            return ResponseParent(code: -1,msg: "uid为空");
        }
        map["uid"] = uid;
        map["nickname"] = nickName;
        map["phone"] = phone;
        map["gender"] = gender;
        var res = await dio.post("user/modify",data: map);
        print(res.data.toString());
        return ResponseParent.fromJson(res.data);
    }

    Future<ResponseParent> addLike(int uid,int dynamicId) async {
        var map = Map<String,dynamic>();
        print("uid----->$uid");
        if (uid == null){
            return ResponseParent(code: -1,msg: "uid为空");
        }
        if (dynamicId == null){
            return ResponseParent(code: -1,msg: "dynamicId为空");
        }
        map["d_id"] = dynamicId;
        map["uid"] = uid;
        var res = await dio.post("index/likedynamic",data: map);
        print(res.data.toString());
        return ResponseParent.fromJson(res.data);
    }

    Future<RecomentBean> getRecomentUsers() async {
        var res = await dio.get("index/userwithlogin");
        return RecomentBean.fromJson(res.data);
    }

    Future<ConversationList> getConversations(String uid) async {
        var map = Map<String,dynamic>();
        map["uid"] = 100;
        var res = await dio.get("conversation/list",queryParameters: map);
        print(res.data.toString());
        return ConversationList.fromJson(res.data);
    }


}