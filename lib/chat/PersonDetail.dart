import 'package:flutter/material.dart';
import 'package:littelchat/common/widgets/view-page.dart';

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
      data.add(Image.asset('images/q1.jpg'));
      data.add(Image.asset('images/a1.jpg'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.5,
            pinned: true,
            expandedHeight: 190,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(top: 20),
                child: ViewPage(),
              ),
            ),
            actions: <Widget>[
              Center(child: Container(
                child: Image.asset('images/setting.png',width: 20,height: 20),
                margin: EdgeInsets.only(right: 16),
              ))
            ],
          ),
          SliverPadding(
              padding: EdgeInsets.only(left: 15),
              sliver: SliverToBoxAdapter(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('姓名'),
                      Text('彭大帅')
                    ],
                  ),
                ),
              ),
          )
         /* SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                      (context,index){
                        return SliverToBoxAdapter(
                          child: Container(
                            child: ListView.builder(
                                itemBuilder: null
                            ),
                          )
                        );
                      },
                  childCount: 22
              ),
              itemExtent: 50,
          )*/
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