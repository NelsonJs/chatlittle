import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:littelchat/bean/AccountBea.dart';
import 'package:littelchat/bean/ChatRecordBean.dart';
import 'package:littelchat/bean/ConversationBean.dart';
import 'package:littelchat/bean/active_bean.dart';
import 'package:littelchat/bean/comment.dart';
import 'package:littelchat/bean/conversation-list.dart';
import 'package:littelchat/bean/like-comment.dart';
import 'package:littelchat/bean/like-dynamic.dart';
import 'package:littelchat/bean/love_intro.dart';
import 'package:littelchat/bean/near_nynamic.dart';
import 'package:littelchat/bean/recoment_users.dart';
import 'package:littelchat/bean/resource_bean.dart';
import 'package:littelchat/bean/respont_parent.dart';
import 'package:littelchat/bean/send-comment.dart';
import 'package:littelchat/bean/travel.dart';
import 'package:littelchat/bean/update-apk.dart';
import 'package:littelchat/common/Global.dart';
import 'package:littelchat/common/util/SpUtils.dart';
import 'package:path_provider/path_provider.dart';

class Net {

    factory Net() => _getInstance();
    static Net _instance;

    Net._();

    static Net _getInstance(){
        if (_instance == null){
            _instance = Net._();
        }
        return _instance;
    }

    /*Net([this.context]){
        _options = Options(extra: {"context":context});
    }*/

    static String _baseUrl = "http://192.168.1.5:8080/";

    BuildContext context;
    Options _options;

    static Dio dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
        connectTimeout: 5000,
        responseType: ResponseType.json
    ));

    static void init() {
      //设置header
    }

    void setBaseUrl(String url){
        _baseUrl = url;
    }

    Future<UpdateBean> getApkUpdate(int version,String channel) async {
        Dio d = Dio(BaseOptions(
            connectTimeout: 5000,
            responseType: ResponseType.json
        ));
        var r = await d.get("http://www.9394.cool:5885/api/apk/query?version=${version+1}&channel=android");
        return UpdateBean.fromJson(r.data);
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
        print(">>>>>>>>>>>>>${r.data}");
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

    Future<NearDynamic> nearDynamicList(int time,int limit) async {
        var uid = await SpUtils().getString(SpUtils.uid);
        var map = Map<String,dynamic>();
        map["uid"] = uid;
        map["offsetTime"] = time;
        map["limit"] = limit;

        Response r = await dio.get("index/neardynamic",queryParameters: map);
        print("nearDynamicList-->"+r.data.toString());
        return NearDynamic.fromJson(r.data);
    }

    Future<CommentBean> getComments() async {
        Response r = await dio.get("comment/list");
        print("getComments--->"+r.data.toString());
        return CommentBean.fromJson(r.data);
    }

    Future<TravelBean> getTravels() async {
        Response r = await dio.get("travel/list");
        print("getTravels--->"+r.data.toString());
        return TravelBean.fromJson(r.data);
    }

    Future<ResponseParent> publishTravel(Map<String,dynamic> params) async {
        Response response = await dio.post("travel/publish",data: params);
        return ResponseParent.fromJson(response.data);
    }

    Future<SendComment> sendComment(String fid,String did,String content,
        String uid,String nickname,String replyUid,String replyNickname) async{
        print(did);
        print(nickname);
        var m = Map<String,dynamic>();
        m["fid"] = fid;
        m["dId"] = did;
        m["content"] = content;
        m["uid"] = uid;
        m["nickname"] = nickname;
        m["replyuid"] = replyUid;
        m["replyname"] = replyNickname;
        Response res = await dio.post("/comment/create",data: m);
        print(res.data);
        return SendComment.fromJson(res.data);
    }


    Future<LikeComment> likeComment(String uid,String cid) async {
        var m = Map<String,dynamic>();
        m["uid"] = uid;
        if (cid != null || cid != "") {
            m["cid"] = cid;
        }
        Response res = await dio.post("/comment/like",data: m);
        return LikeComment.fromJson(res.data);
    }

    Future<LikeDynamic> likeDynamic(String uid,String did) async {
        var m = Map<String,dynamic>();
        m["uid"] = uid;
        if (did != null || did != "") {
            m["did"] = did;
        }
        Response res = await dio.post("index/dynamic/like",data: m);
        return LikeDynamic.fromJson(res.data);
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

    Future<ResourceBean> publishDynamic(List<String> ids,String title) async {
        var map = Map<String,dynamic>();
        var uid = await SpUtils().getString(SpUtils.uid);
        if (!uid.isNotEmpty){
            ResourceBean rb = ResourceBean(code: -1,msg: "uid为空");
            return rb;
        }
        map["uid"] = uid;
        map["title"] = title;
        map["resImg"] = ids;
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