import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/bean/constants.dart';
import 'package:littelchat/bean/expand-bean.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/widgets/SnackBackUtil.dart';

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
  TextEditingController carDescController = TextEditingController();
  TextEditingController curPeopleNumController = TextEditingController();
  TextEditingController totalPeopleNumController = TextEditingController();
  TextEditingController noticeController = TextEditingController();

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
          Builder(builder: (BuildContext c){
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 14),
                child: Center(
                  child: Text('${Constants.PUBLISH}'),
                ),
              ),
              onTap: (){
                var params = Map<String,dynamic>();
                params["ttype"] = selectTravelTypeValue;
                params["startloc"] = startPlace;
                params["endloc"] = endPlace;
                params["cartype"] = selectCarTypeValue;
                params["curnum"] = int.parse(curPeopleNumController.text.toString());
                params["total"] = int.parse(totalPeopleNumController.text.toString());
                params["price"] = selectMoneyType;
                if (hasSetDate && hasSetTime){
                  params["starttime"] = _selectedDate.millisecond+_selectedTime.hour*60*60*1000+_selectedTime.minute*60*1000;
                } else if (hasSetDate){
                  params["starttime"] = _selectedDate.millisecond;
                }
                params["description"] = noticeController.text.toString();
                if ("${Constants.SELF_DRIVING}" == selectCarTypeValue){
                  params["car"] = carDescController.text.toString();
                }
                Net().publishTravel(params).then((value){
                  if (value.code == 1){
                    SnackBarUtil().showToast(c,"${Constants.PUBLISH_SUCCESSFUL}");
                    Navigator.pop(context,Constants.SUCCESSFUL);
                  } else {
                    SnackBarUtil().showToast(c,"${value.msg}");
                  }
                });
              },
            );
          })
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
                  offstage: selectTravelTypeValue == "${Constants.GO_OUT}" ? false : true,
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
                          offstage: selectCarTypeValue == "${Constants.SELF_DRIVING}" ? false : true,
                          child: Container(
                            margin: EdgeInsets.only(right: 16,top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${Constants.CAR_DESC_LABEL}",style: TextStyle(fontSize: 12,color: Colors.grey)),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: "${Constants.CAR_DESC_HINT}",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                    contentPadding: EdgeInsets.all(0),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                  ),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.text,
                                  maxLength: 15,
                                  controller: carDescController,
                                ),
                                Text("${Constants.PEOPLE_NUM_SET}",style: TextStyle(fontSize: 12,color: Colors.grey)),
                                Row(
                                  children: [
                                    Container(
                                      child: SizedBox.fromSize(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: "${Constants.SET_HAS_PEOPLE_NUM}",
                                            contentPadding: EdgeInsets.all(0),
                                            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                          ),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                          controller: curPeopleNumController,
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
                                            hintText: "${Constants.SET_TOTAL_NUM}",
                                            contentPadding: EdgeInsets.all(0),
                                            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                          ),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                          controller: totalPeopleNumController,
                                        ),
                                        size: Size(100, 40),
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  children: [
                                    Text("${Constants.PRICE_LEVEL}",style: TextStyle(color: Colors.grey,fontSize: 13)),
                                    _driveMoneySelect(),
                                  ],
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: "${Constants.NOTICE_HINT}",
                                    hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                    contentPadding: EdgeInsets.all(0),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300],width: 1),borderRadius: BorderRadius.all(Radius.circular(2))),
                                  ),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.text,
                                  maxLines: 4,
                                  controller: noticeController,
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
  bool hasSetDate = false;
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
          hasSetDate = true;
          _showTimePicker();
        }
      });
    });
  }

  //调起时间选择器
  TimeOfDay _selectedTime = TimeOfDay.now(); //当前选中的时间
  bool hasSetTime = false;
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
        hasSetTime = true;
        this._selectedTime = result;
        selectTravelTime = "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day} ${_selectedTime.hour}:${_selectedTime.minute}";
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