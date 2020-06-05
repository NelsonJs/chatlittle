import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends Dialog{
  @override
  Widget build(BuildContext context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: ShapeDecoration(color:Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))),
            child: SizedBox(width: 100,height: 100,child: CupertinoActivityIndicator(animating: true,radius: 20),),
          ),
        ),
      );
  }
}