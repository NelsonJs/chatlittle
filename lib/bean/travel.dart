class TravelBean {
  int code;
  String msg;
  List<TravelData> data;

  TravelBean({this.code, this.msg,this.data});

  TravelBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<TravelData>();
      json['data'].forEach((v) {
        data.add(new TravelData.fromJson(v));
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

class TravelData {
  String startPlace;
  String endPlace;
  String travelType;
  List<Travels> travels;

  TravelData({this.startPlace, this.endPlace, this.travelType, this.travels});

  TravelData.fromJson(Map<String, dynamic> json) {
    startPlace = json['start_place'];
    endPlace = json['end_place'];
    travelType = json['travel_type'];
    if (json['travels'] != null) {
      travels = new List<Travels>();
      json['travels'].forEach((v) {
        travels.add(new Travels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_place'] = this.startPlace;
    data['end_place'] = this.endPlace;
    data['travel_type'] = this.travelType;
    if (this.travels != null) {
      data['travels'] = this.travels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Travels {
  String tid;
  String ttype;
  String car;
  int carnum;
  String uid;
  String title;
  int starttime;
  String startloc;
  String driveloc;
  String endloc;
  int loclat;
  int loclng;
  String price;
  int total;
  int curnum;
  String description;
  List<Members> members;
  int status;
  int createtime;

  Travels(
      {this.tid,
        this.ttype,
        this.car,
        this.carnum,
        this.uid,
        this.title,
        this.starttime,
        this.startloc,
        this.driveloc,
        this.endloc,
        this.loclat,
        this.loclng,
        this.price,
        this.total,
        this.curnum,
        this.description,
        this.members,
        this.status,
        this.createtime});

  Travels.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    ttype = json['ttype'];
    car = json['car'];
    carnum = json['carnum'];
    uid = json['uid'];
    title = json['title'];
    starttime = json['starttime'];
    startloc = json['startloc'];
    driveloc = json['driveloc'];
    endloc = json['endloc'];
    loclat = json['loclat'];
    loclng = json['loclng'];
    price = json['price'];
    total = json['total'];
    curnum = json['curnum'];
    description = json['description'];
    if (json['members'] != null) {
      members = new List<Members>();
      json['members'].forEach((v) {
        members.add(new Members.fromJson(v));
      });
    }
    status = json['status'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['ttype'] = this.ttype;
    data['car'] = this.car;
    data['carnum'] = this.carnum;
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['starttime'] = this.starttime;
    data['startloc'] = this.startloc;
    data['driveloc'] = this.driveloc;
    data['endloc'] = this.endloc;
    data['loclat'] = this.loclat;
    data['loclng'] = this.loclng;
    data['price'] = this.price;
    data['total'] = this.total;
    data['curnum'] = this.curnum;
    data['description'] = this.description;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createtime'] = this.createtime;
    return data;
  }
}

class Members {
  String uid;
  String avatar;

  Members({this.uid, this.avatar});

  Members.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['avatar'] = this.avatar;
    return data;
  }
}
