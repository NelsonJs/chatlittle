import 'package:flutter/material.dart';

class PersonDetail extends StatefulWidget {
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<PersonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('images/p1.jpg'),
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                      (context,index)=>ListTile(title: Text('data')), childCount: 22
              ),
              itemExtent: 50,
          )
        ],
      ),
    );
  }

}