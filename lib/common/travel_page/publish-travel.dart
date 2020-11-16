import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';

class PublishTravel extends StatefulWidget {
  @override
  _StatePublishTravel createState() => _StatePublishTravel();
}

class _StatePublishTravel extends State<PublishTravel>{
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            GestureDetector(
              child: Text('选择地址'),
              onTap: (){
                _getLoc();
              },
            )
          ],
        ),
      ),
    );
  }
  Result resultArr  = Result();
  _getLoc() async {
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
    }
  }

}