
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarUtil {

  showToast(BuildContext context,String content){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(seconds: 1),
    ));
  }

}