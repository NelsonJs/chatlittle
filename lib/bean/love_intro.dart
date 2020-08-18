class LoveIntro {
  List<LoveIntroData> data;

  LoveIntro({this.data});

  LoveIntro.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<LoveIntroData>();
      json['data'].forEach((v) {
        data.add(new LoveIntroData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoveIntroData {
  int id;
  int uid;
  String nickname;
  String img;
  int gender;
  String habit;
  String jiGuan;
  String curLocal;
  String xueLi;
  String job;
  String shenGao;
  String tiZhong;
  String loveWord;
  int createTime;

  LoveIntroData(
      {this.id,
        this.uid,
        this.nickname,
        this.img,
        this.gender,
        this.habit,
        this.jiGuan,
        this.curLocal,
        this.xueLi,
        this.job,
        this.shenGao,
        this.tiZhong,
        this.loveWord,
        this.createTime});

  LoveIntroData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    nickname = json['nickname'];
    img = json['img'];
    gender = json['gender'];
    habit = json['habit'];
    jiGuan = json['ji_guan'];
    curLocal = json['cur_local'];
    xueLi = json['xue_li'];
    job = json['job'];
    shenGao = json['shen_gao'];
    tiZhong = json['ti_zhong'];
    loveWord = json['love_word'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['img'] = this.img;
    data['gender'] = this.gender;
    data['habit'] = this.habit;
    data['ji_guan'] = this.jiGuan;
    data['cur_local'] = this.curLocal;
    data['xue_li'] = this.xueLi;
    data['job'] = this.job;
    data['shen_gao'] = this.shenGao;
    data['ti_zhong'] = this.tiZhong;
    data['love_word'] = this.loveWord;
    data['create_time'] = this.createTime;
    return data;
  }
}
