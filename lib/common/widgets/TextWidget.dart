
import 'package:flutter/material.dart';

class TextIconWidget extends StatefulWidget {
    Key key;
    String _txt;
    IconData _iconData;
    TextIconWidget(this.key,this._txt,this._iconData);

  @override
  State<StatefulWidget> createState() => TextIconWidgetState();
}

class TextIconWidgetState extends State<TextIconWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(widget._iconData),
        Text(widget._txt)
      ],
    );
  }

  void setTxtData(String txt) {
     setState(() {
       widget._txt = txt;
     });
  }

  void setIconData(IconData iconData) {
    setState(() {
      widget._iconData = iconData;
    });
  }

}