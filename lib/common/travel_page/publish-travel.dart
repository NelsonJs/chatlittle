import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/expand-bean.dart';

class PublishTravel extends StatefulWidget {
  @override
  _StatePublishTravel createState() => _StatePublishTravel();
}

class _StatePublishTravel extends State<PublishTravel>{
  List<String> travelTypes = [];
  List<String> travelCarTypes = [];
  List<String> driveMoneys = [];
  List<String> carTotalNum = [];
  String startPlace = "出发地",endPlace = "目的地",selectTravelTime = "选择出行时间",selectTravelPlace = "选择集合地点";

  @override
  void initState() {
    travelTypes.clear();
    travelTypes.add('出行');
    travelTypes.add('活动');
    travelCarTypes.clear();
    travelCarTypes.add("自驾");
    travelCarTypes.add("动车");
    travelCarTypes.add("飞机");
    driveMoneys.clear();
    driveMoneys.add('免费');
    driveMoneys.add('油费AA');
    driveMoneys.add('自定义');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        actions: [
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 14),
                child: Center(
                  child: Text('发布'),
                ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xf2f4f5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _travelType(),

                ],
              ),
              Offstage(
                  offstage: selectTravelTypeValue == "出行" ? false : true,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            FlatButton(
                              color: Colors.grey,
                              textColor: Colors.black87,
                              height: 35,
                              onPressed: (){
                                _getLoc(1);
                              }, //如果onPressed里面填null，则背景颜色会显示异常
                              child:  Text("$startPlace",style: TextStyle(fontSize: 13)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  side: BorderSide(style: BorderStyle.solid,color: Colors.white)
                              ),),

                            Text("    >    "),
                            FlatButton(
                              color: Colors.grey,
                              textColor: Colors.black87,
                              height: 35,
                              onPressed: (){
                                _getLoc(2);
                              }, //如果onPressed里面填null，则背景颜色会显示异常
                              child:  Text("$endPlace",style: TextStyle(fontSize: 13)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  side: BorderSide(style: BorderStyle.solid,color: Colors.white)
                              ),),

                            Expanded(child: Text("")),
                            Container(
                              child: _travelCarType(),
                              margin: EdgeInsets.only(right: 16),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        Offstage(
                          offstage: selectCarTypeValue == "自驾" ? false : true,
                          child: Container(
                            margin: EdgeInsets.only(right: 16,top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("为方便识别，请输入车辆描述:",style: TextStyle(fontSize: 12,color: Colors.grey)),//汽车描述如：哈弗F7X 黑色 闽D8DJ21
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: "汽车描述如：哈弗F7X 黑色 闽D8DJ21",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                    contentPadding: EdgeInsets.all(0),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                  ),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 15,
                                ),
                                Text("人数设置:",style: TextStyle(fontSize: 12,color: Colors.grey)),
                                Row(
                                  children: [
                                    Container(
                                      child: SizedBox.fromSize(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: "设置可搭载人数",
                                            contentPadding: EdgeInsets.all(0),
                                            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                          ),
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.phone,
                                        ),
                                        size: Size(100, 40),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10),
                                    ),
                                    Text(" / "),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: SizedBox.fromSize(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: "设置总人数",
                                            contentPadding: EdgeInsets.all(0),
                                            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                          ),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                        ),
                                        size: Size(100, 40),
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  children: [
                                    Text("资费标准：",style: TextStyle(color: Colors.grey,fontSize: 13)),
                                    _driveMoneySelect(),
                                  ],
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: "公告如：输入公告：例如:大家少带一点东西~",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                    contentPadding: EdgeInsets.all(0),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                  ),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.phone,
                                  maxLines: 4,
                                ),
                                Container(
                                    child: FlatButton(
                                      color: Colors.grey,
                                      textColor: Colors.black87,
                                      height: 35,
                                      onPressed: (){
                                        _showDatePicker();
                                      }, //如果onPressed里面填null，则背景颜色会显示异常
                                      child:  Text("$selectTravelTime",style: TextStyle(fontSize: 13)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(4)),
                                          side: BorderSide(style: BorderStyle.solid,color: Colors.white)
                                      ),)
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }

  //调起日期选择器
  DateTime _selectedDate = DateTime.now(); //当前选中的日期
  _showDatePicker() {
    //获取异步方法里面的值的第一种方式：then
    showDatePicker(
      //如下四个参数为必填参数
      context: context,
      initialDate: _selectedDate, //选中的日期
      firstDate: DateTime(1980), //日期选择器上可选择的最早日期
      lastDate: DateTime(2100), //日期选择器上可选择的最晚日期
      locale: Locale("zh")
    ).then((selectedValue) {
      setState(() {
        if (selectedValue != null){
          //将选中的值传递出来
          this._selectedDate = selectedValue;
          _showTimePicker();
        }
      });
    });
  }

  //调起时间选择器
  TimeOfDay _selectedTime = TimeOfDay.now(); //当前选中的时间
  _showTimePicker() async {
    // 获取异步方法里面的值的第二种方式：async+await
    //await的作用是等待异步方法showDatePicker执行完毕之后获取返回值
    var result = await showTimePicker(
      context: context,
      initialTime: _selectedTime, //选中的时间
    );
    //将选中的值传递出来
    setState(() {
      if (result != null) {
        this._selectedTime = result;
      }
    });
  }

  Result resultArr  = Result();
  _getLoc(int type) async {
    Result tempResult = await CityPickers.showCityPicker(
        context: context,
      locationCode: resultArr != null ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId : null,
        cancelWidget: Text(
          '取消',
          style: TextStyle(fontSize: 16,color: Color(0xff999999)),
        ),
        confirmWidget: Text(
          '确定',
          style: TextStyle(fontSize: 16,color: Color(0xfffe1314)),
        ),
        height: 220.0
    );
    if (tempResult != null){
      resultArr = tempResult;
      if (tempResult.provinceName != null) {
        if (tempResult.cityName != null) {
          setState(() {
            if (type == 1){//出行选择出发地
              if (tempResult.areaName != null) {
                startPlace = tempResult.areaName;
              } else {
                startPlace = tempResult.cityName;
              }
            } else if (type == 2) {//出行选择目的地
              if (tempResult.areaName != null) {
                endPlace = tempResult.areaName;
              } else {
                endPlace = tempResult.cityName;
              }
            }
          });
        }
      }

    }
  }

  String selectMoneyType = "免费";
  Widget _driveMoneySelect() {
    return DropdownButton<String>(
      value: selectMoneyType,
      items: driveMoneys.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 13)),
        );
      }).toList(),
      onChanged: (String value){
        setState(() {
          selectMoneyType = value;
        });
      },
    );
  }

  String selectTravelTypeValue = "出行";
  Widget _travelType() {
    return DropdownButton<String>(
        value: selectTravelTypeValue,
        items: travelTypes.map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(fontSize: 13)),
          );
        }).toList(),
        onChanged: (String value){
          setState(() {
            selectTravelTypeValue = value;
          });
        },
    );
  }

  String selectCarTypeValue = "自驾";
  Widget _travelCarType() {
    return DropdownButton<String>(
      value: selectCarTypeValue,
      items: travelCarTypes.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 13)),
        );
      }).toList(),
      onChanged: (String value){
        setState(() {
          selectCarTypeValue = value;
        });
      },
    );
  }


}