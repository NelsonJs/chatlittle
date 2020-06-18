import 'package:flutter/material.dart';

class PersonDetail extends StatefulWidget {
  final int uid;

  PersonDetail(this.uid);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<PersonDetail> {
  List<Image> data = [];

  @override
  void initState() {
    setState(() {
      data.add(Image.asset('images/p1.jpg'));
      data.add(Image.asset('images/p1.jpg'));
      data.add(Image.asset('images/p1.jpg'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: PageView.builder(itemBuilder: (context,index){
                return data[index];
              },itemCount: data.length)
            ),
            actions: <Widget>[
              Center(child: Container(
                child: Image.asset('images/setting.png',width: 20,height: 20),
                margin: EdgeInsets.only(right: 16),
              ))
            ],
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

  showPop() {
    showMenu(context: context, position: null, items: <PopupMenuEntry>[
      PopupMenuItem(child: Text('设置昵称'))
    ]);
  }

}