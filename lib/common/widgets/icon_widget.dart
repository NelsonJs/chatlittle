import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  IconData iconData;
  String txt;
  final Key key;


  IconWidget(this.key,this.iconData, this.txt);

  @override
  State<StatefulWidget> createState() => StateIconWidget();
}

class StateIconWidget extends State<IconWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(widget.iconData),
        Container(
          child: Text(widget.txt),
          margin: EdgeInsets.only(left: 5),
        )
      ],
    );
  }

  void setIconTxt(IconData icon,String txt) {
    setState(() {
        widget.iconData = icon;
        widget.txt = "$txt";
      });
  }
}