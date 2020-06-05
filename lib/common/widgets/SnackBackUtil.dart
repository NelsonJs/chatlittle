
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarUtil extends StatelessWidget{
  final String showTxt;
  
  SnackBarUtil(this.showTxt);
  
  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(showTxt));
  }

}