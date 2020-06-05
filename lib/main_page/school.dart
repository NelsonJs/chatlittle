import 'package:flutter/material.dart';

class School extends StatefulWidget{
  @override
  SchoolPage createState() => SchoolPage();
}

class SchoolPage extends State<School> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('广场'),
      ),
    );
  }

}