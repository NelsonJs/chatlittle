class NearDynamic {
  int code;
  List<Data> data;

  NearDynamic({this.code, this.data});

  NearDynamic.fromJson(Map<String, dynamic> json) {
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
  int id;
  int uid;
  String title;
  String desc;
  String img;
  int gender;
  String begin;
  String location;
  int lng;
  int lat;
  int peoplenum;
  int peopletotalnum;
  int like;
  int commentnum;
  int commentid;
  List<String> resImg;


  Data(
      {this.id,
        this.uid,
        this.title,
        this.desc,
        this.img,
        this.gender,
        this.begin,
        this.location,
        this.lng,
        this.lat,
        this.peoplenum,
        this.peopletotalnum,
        this.like,
        this.commentnum,
        this.commentid,
        this.resImg});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    title = json['title'];
    desc = json['desc'];
    img = json['img'];
    gender = json['gender'];
    begin = json['begin'];
    location = json['location'];
    lng = json['lng'];
    lat = json['lat'];
    peoplenum = json['peoplenum'];
    peopletotalnum = json['peopletotalnum'];
    like = json['like'];
    commentnum = json['commentnum'];
    commentid = json['commentid'];
    if (json['res_img'] != null) {
      resImg = json['res_img'].cast<String>();
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['img'] = this.img;
    data['gender'] = this.gender;
    data['begin'] = this.begin;
    data['location'] = this.location;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['peoplenum'] = this.peoplenum;
    data['peopletotalnum'] = this.peopletotalnum;
    data['like'] = this.like;
    data['commentnum'] = this.commentnum;
    data['commentid'] = this.commentid;
    data['res_img'] = this.resImg;
    return data;
  }
}
