class ActiveBean {
  int code;
  List<Data> data;

  ActiveBean({this.code, this.data});

  ActiveBean.fromJson(Map<String, dynamic> json) {
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
  String uid;
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
  String commentid;

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
        this.commentid});

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
    return data;
  }
}